import 'package:flutter/material.dart';

enum DisplaySize { xsmall, small, medium, large, xlarge }

class Window {
  static const Map<DisplaySize, double> _displaySizeToWidth = <DisplaySize, double>{
    DisplaySize.xsmall: 0,
    DisplaySize.small: 360,
    DisplaySize.medium: 600,
    DisplaySize.large: 720,
    DisplaySize.xlarge: 1024,
  };

  static double width(DisplaySize displaySize) {
    return _displaySizeToWidth[displaySize];
  }

  // todo: use breakpoint
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width > width(DisplaySize.large);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width <= width(DisplaySize.large);
}


class Responsive extends StatelessWidget {

  const Responsive({Key key, @required this.desktop, @required this.mobile}) : super(key: key);

  /// Only display given child for desktop sized devices.
  const Responsive.onlyDesktop({ Key key, Widget child })
      : mobile = const SizedBox.shrink(),
        desktop = child,
        super(key: key);

  /// Only display given child for mobile sized devices.
  const Responsive.onlyMobile({ Key key, Widget child })
      : desktop = const SizedBox.shrink(),
        mobile = child,
        super(key: key);

  final Widget desktop;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    if (Window.isDesktop(context)) {
      return desktop;
    }
    return mobile;
  }
}
