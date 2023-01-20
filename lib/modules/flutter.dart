import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart' as p;
//import 'package:process_run/shell.dart';
import 'package:pubspec/pubspec.dart';
import 'package:version/version.dart' as v;

import 'yaml.dart';

//import 'yaml_to_string.dart';

// ignore: avoid_classes_with_only_static_members
class Flutter {
  static final _pubspecFile = File('pubspec.yaml');

  /// separtor
  static final _mapSep = _PubValue<String>(() {
    var yaml = pubSpec.unParsedYaml!;
    if (yaml.containsKey('get_cli')) {
      if ((yaml['get_cli'] as Map).containsKey('separator')) {
        return (yaml['get_cli']['separator'] as String?) ?? '';
      }
    }

    return '';
  });

  static final _mapName = _PubValue<String>(() => pubSpec.name?.trim() ?? '');

  static final _extraFolder = _PubValue<bool?>(
    () {
      try {
        var yaml = pubSpec.unParsedYaml!;
        if (yaml.containsKey('get_cli')) {
          if ((yaml['get_cli'] as Map).containsKey('sub_folder')) {
            return (yaml['get_cli']['sub_folder'] as bool?);
          }
        }
      } on Exception catch (_) {}
      // retorno nulo está sendo tratado
      // ignore: avoid_returning_null
      return null;
    },
  );

  static bool? get extraFolder => _extraFolder.value;

  static String get getPackageImport => "import 'package:get/get.dart';";

  static bool get nullSafeSupport =>
      !pubSpec.environment!.sdkConstraint!.allowsAny(HostedReference.fromJson('<2.12.0').versionConstraint);

  static String? get projectName => _mapName.value;

  static PubSpec get pubSpec => PubSpec.fromYamlString(_pubspecFile.readAsStringSync());

  static String? get separatorFileType => _mapSep.value;

  static Future<void> activatedNullSafe() async {
    await pubGet();
    //await run('dart migrate --apply-changes --skip-import-check', verbose: true);
  }

  static bool containsPackage(String package, [bool isDev = false]) {
    var dependencies = isDev ? pubSpec.devDependencies : pubSpec.dependencies;
    return dependencies.containsKey(package.trim());
  }

  static Future<void> create(
    String path,
    String name,
    String? org,
    String iosLang,
    String androidLang,
  ) async {
    print('Running `flutter create $path` …');
    await Directory(path).create(recursive: true);

    await Process.run(
      'flutter',
      [
        'create',
        '--no-pub',
        '-i',
        iosLang,
        '-a',
        androidLang,
        '--org',
        org ?? 'com.example',
        name,
      ],
      runInShell: true,
      workingDirectory: path,
    );
    path = p.join(path, name);
    Directory.current = path;
    /* await run(
      'flutter create --no-pub -i $iosLang -a $androidLang --org $org'
      ' "$path"',
    ); */
  }

  static Future<String?> getLatestVersionFromPackage(String package) async {
    final languageCode = Platform.localeName.split('_')[0];
    final pubSite = languageCode == 'zh'
        ? 'https://pub.flutter-io.cn/api/packages/$package'
        : 'https://pub.dev/api/packages/$package';
    var uri = Uri.parse(pubSite);
    try {
      var value = await get(uri);
      if (value.statusCode == 200) {
        final version = json.decode(value.body)['latest']['version'] as String?;
        return version;
      } else if (value.statusCode == 404) {
        throw '获取包[$package]版本失败';
      }
      return null;
    } on Exception catch (err) {
      throw err.toString();
    }
  }

  static v.Version? getPackageVersion(String package) {
    if (containsPackage(package)) {
      var version = pubSpec.allDependencies[package]!;
      try {
        final json = version.toJson();
        if (json is String) {
          return v.Version.parse(json);
        }
        return null;
      } on FormatException catch (_) {
        return null;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      throw '包$package没有安装';
    }
  }

  static Future<bool> pubAdd(String package, {String? version, bool isDev = false, bool runPubGet = false}) async {
    var pubSpec = PubSpec.fromYamlString(_pubspecFile.readAsStringSync());

    if (containsPackage(package)) {
      return false;
    }

    version = version == null || version.isEmpty ? await getLatestVersionFromPackage(package) : '^$version';
    if (version == null) return false;
    if (isDev) {
      pubSpec.devDependencies[package] = HostedReference.fromJson(version);
    } else {
      pubSpec.dependencies[package] = HostedReference.fromJson(version);
    }

    _savePub(pubSpec);
    if (runPubGet) await pubGet();
    return true;
  }

  static Future<void> pubGet() async {
    print('Running `flutter pub get` …');
    Process.run('flutter', ['pub', 'get'], runInShell: true);
    //await run('flutter pub get', verbose: true);
  }

  static void pubRemove(String package, {bool logger = true}) {
    if (containsPackage(package)) {
      var dependencies = pubSpec.dependencies;
      var devDependencies = pubSpec.devDependencies;

      dependencies.removeWhere((key, value) => key == package);
      devDependencies.removeWhere((key, value) => key == package);
      var newPub = pubSpec.copy(
        devDependencies: devDependencies,
        dependencies: dependencies,
      );
      _savePub(newPub);
      if (logger) {
        print('包删除成功');
      }
    } else if (logger) {
      print('包$package没有安装');
    }
  }

  static void _savePub(PubSpec pub) {
    var value = const Yaml().toStringEx(pub.toJson());
    _pubspecFile.writeAsStringSync(value);
  }
}

/// avoids multiple reads in one file
class _PubValue<T> {
  final T Function() _setValue;
  bool _isChecked = false;
  T? _value;

  _PubValue(this._setValue);

  /// takes the value of the file,
  /// if not already called it will call the first time
  T? get value {
    if (!_isChecked) {
      _isChecked = true;
      _value = _setValue.call();
    }
    return _value;
  }
}
