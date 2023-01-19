final _unsuportedCharacters =
    RegExp(r'''^[\n\t ,[\]{}#&*!|<>'"%@']|^[?-]$|^[?-][ \t]|[\n:][ \t]|[ \t]\n|[\n\t ]#|[\n\t :]$''');

class Yaml {
  static const _divider = ': ';

  final String indent, quotes;
  const Yaml({
    this.indent = ' ',
    this.quotes = "'",
  });

  String toStringEx(dynamic node) {
    final stringBuffer = StringBuffer();
    writeString(node, stringBuffer);
    return stringBuffer.toString();
  }

  /// Serializes [node] into a String and writes it to the [sink].
  void writeString(dynamic node, StringSink sink) {
    _writeString(node, 0, sink, true, false);
  }

  String _escapeString(String line) {
    line = line.replaceAll('"', r'\"').replaceAll('\n', r'\n');

    if (line.contains(_unsuportedCharacters)) {
      line = quotes + line + quotes;
    }

    return line;
  }

  void _listToString(
    Iterable node,
    int indentCount,
    StringSink stringSink,
    bool isTopLevel,
  ) {
    if (!isTopLevel) {
      stringSink.writeln();
      indentCount += 2;
    }

    for (var value in node) {
      _writeIndent(indentCount, stringSink);
      stringSink.write('- ');
      _writeString(value, indentCount, stringSink, false, true);
    }
  }

  void _mapToString(
    Map<String, dynamic> node,
    int indentCount,
    StringSink stringSink,
    bool isTopLevel,
    bool isList,
  ) {
    if (!isTopLevel) {
      if (!isList) {
        stringSink.writeln();
      }
      indentCount += 2;
    }
    final keys = _sortKeys(node);

    if (isList) {
      for (var key in keys) {
        final value = node[key];
        if (value is Iterable || value is Map) {
          _writeIndent(indentCount, stringSink);
        }
        stringSink
          ..write(key)
          ..write(_divider);
        _writeString(value, indentCount, stringSink, false, false);
      }
    } else {
      for (var key in keys) {
        final value = node[key];
        _writeIndent(indentCount, stringSink);
        stringSink
          ..write(key)
          ..write(_divider);
        _writeString(value, indentCount, stringSink, false, false);
        if (value is Map || value is Iterable) {
          if (isTopLevel) {
            stringSink.writeln('');
          }
        }
      }
    }
  }

  Iterable<String> _sortKeys(Map<String, dynamic> map) {
    final simple = <String>[], maps = <String>[], lists = <String>[], other = <String>[];

    map.forEach((key, value) {
      if (value is String) {
        simple.add(key);
      } else if (value is Map) {
        maps.add(key);
      } else if (value is Iterable) {
        lists.add(key);
      } else {
        other.add(key);
      }
    });

    return [...simple, ...maps, ...lists, ...other];
  }

  void _writeIndent(int indentCount, StringSink stringSink) => stringSink.write(indent * indentCount);

  void _writeString(node, int indentCount, StringSink stringSink, bool isTopLevel, bool isList) {
    if (node is Map) {
      _mapToString(node.cast<String, dynamic>(), indentCount, stringSink, isTopLevel, isList);
    } else if (node is Iterable) {
      _listToString(node, indentCount, stringSink, isTopLevel);
    } else if (node is String) {
      stringSink.writeln(_escapeString(node));
    } else if (node is double) {
      stringSink.writeln('!!float $node');
    } else {
      stringSink.writeln(node);
    }
  }
}
