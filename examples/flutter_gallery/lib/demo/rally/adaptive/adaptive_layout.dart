import 'package:flutter/material.dart';

enum DeviceSize { Desktop, Mobile }

class Device {
  static DeviceSize getDeviceSize(MediaQueryData mediaQueryData) => mediaQueryData.size.shortestSide > 900 ? DeviceSize.Desktop : DeviceSize.Mobile;

  static bool isDesktop(BuildContext context) => getDeviceSize(MediaQuery.of(context)) == DeviceSize.Desktop;

  static bool isMobile(BuildContext context) => !isDesktop(context);
}


class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({Key key, @required this.desktop, @required this.mobile}) : super(key: key);

  /// Only display given child for desktop sized devices.
  const AdaptiveLayout.onlyDesktop({ Key key, Widget child })
      : mobile = const SizedBox.shrink(),
        desktop = child,
        super(key: key);

  /// Only display given child for mobile sized devices.
  const AdaptiveLayout.onlyMobile({ Key key, Widget child })
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

