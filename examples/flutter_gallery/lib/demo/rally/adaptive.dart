import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

class Device {
  static bool isDesktop(BuildContext context) => Breakpoint.fromMediaQuery(context).device == LayoutClass.desktop;
}

class Adaptive extends StatelessWidget {

  const Adaptive({Key key, @required this.desktop, @required this.mobile}) : super(key: key);

  /// Only display given child for desktop sized devices.
  const Adaptive.onlyDesktop({ Key key, Widget child })
      : mobile = const SizedBox.shrink(),
        desktop = child,
        super(key: key);

  /// Only display given child for mobile sized devices.
  const Adaptive.onlyMobile({ Key key, Widget child })
      : desktop = const SizedBox.shrink(),
        mobile = child,
        super(key: key);

  final Widget desktop;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    if (Device.isDesktop(context)) {
      return desktop;
    }
    return mobile;
  }
}
