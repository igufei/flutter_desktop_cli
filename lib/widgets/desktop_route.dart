import 'package:flutter/widgets.dart';

import 'fade_indexed_stack.dart';

class DesktopRoute extends StatefulWidget {
  final RouteController controller;
  final Widget initWidget;
  const DesktopRoute({
    super.key,
    required this.controller,
    required this.initWidget,
  });

  @override
  State<DesktopRoute> createState() => _DesktopRouteState();
}

class RouteController extends ChangeNotifier {
  final List<Widget> _views = [];
  List<Widget> get views => _views;

  void back() {
    if (_views.length > 1) {
      _views.removeLast();
      notifyListeners();
    }
  }

  void next(Widget widget) {
    _views.add(widget);
    notifyListeners();
  }
}

class _DesktopRouteState extends State<DesktopRoute> {
  int viewIndex = 0;
  @override
  Widget build(BuildContext context) {
    /*  return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(animation),
          child: child,
        );
      },
      duration: Duration(milliseconds: 200),
      child: IndexedStack(
        index: viewIndex,
        children: widget.controller.views,
      ),
    );
 */
    return FadeIndexedStack(
      index: viewIndex,
      children: widget.controller.views,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  @override
  void initState() {
    if (widget.controller.views.length == 0) {
      widget.controller.next(widget.initWidget);
    } else {
      if (mounted) {
        setState(() {
          viewIndex = widget.controller.views.length - 1;
        });
      }
    }

    widget.controller.addListener(listener);
    super.initState();
  }

  void listener() {
    if (mounted) {
      setState(() {
        viewIndex = widget.controller.views.length - 1;
      });
    }
  }
}
