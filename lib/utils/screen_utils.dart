

import '../const/screen_sizes.dart';

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

class ScreenUtils {
  DeviceType deviceType(double size) {
    if (size < ScreenSizes.mobileMaxSize) {
      return DeviceType.mobile;
    } else if (size >= ScreenSizes.mobileMaxSize &&
        size < ScreenSizes.tabletMaxSize) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
}
