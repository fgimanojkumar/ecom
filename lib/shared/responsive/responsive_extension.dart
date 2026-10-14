import 'package:flutter/material.dart';
import 'responsive_config.dart';

/// Extension on BuildContext to access responsive utilities easily
extension ResponsiveExtension on BuildContext {
  /// Get current screen size info
  ScreenSize get screenSize {
    final mediaQuery = MediaQuery.of(this);
    return ScreenSize(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      deviceType: getDeviceType(mediaQuery.size.width),
      isLandscape: mediaQuery.orientation == Orientation.landscape,
    );
  }

  /// Check if device is mobile
  bool get isMobile => screenSize.isMobile;

  /// Check if device is tablet
  bool get isTablet => screenSize.isTablet;

  /// Check if device is desktop
  bool get isDesktop => screenSize.isDesktop;

  /// Get responsive width (with max constraint)
  double get responsiveWidth {
    if (isDesktop && screenSize.width > ResponsiveConfig.maxContentWidth) {
      return ResponsiveConfig.maxContentWidth;
    }
    return screenSize.width;
  }

  /// Get responsive padding
  double get responsivePadding => screenSize.padding;

  /// Get responsive border radius
  double get responsiveRadius => screenSize.borderRadius;

  /// Get responsive icon size
  double get responsiveIconSize => screenSize.iconSize;

  /// Get responsive grid columns
  int get responsiveGridColumns => screenSize.gridColumns;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get text scale factor (for typography)
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  /// Check if landscape
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Check if portrait
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  /// Get device padding (safe area)
  EdgeInsets get devicePadding => MediaQuery.of(this).padding;

  /// Get viewInsets (keyboard height)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;
}

/// Extension on Size for responsive calculations
extension SizeExtension on Size {
  /// Check if width matches mobile breakpoint
  bool get isMobileWidth => width < ResponsiveConfig.tabletBreakpoint;

  /// Check if width matches tablet breakpoint
  bool get isTabletWidth =>
      width >= ResponsiveConfig.tabletBreakpoint &&
      width < ResponsiveConfig.desktopBreakpoint;

  /// Check if width matches desktop breakpoint
  bool get isDesktopWidth => width >= ResponsiveConfig.desktopBreakpoint;

  /// Get width percentage (100 = full width)
  double getWidthPercent(double percent) => width * (percent / 100);

  /// Get height percentage
  double getHeightPercent(double percent) => height * (percent / 100);
}

/// Extension on double for responsive sizing
extension ResponsiveDimension on double {
  /// Get responsive font size based on device
  /// Base size is for mobile, scales up on larger devices
  double get responsiveFontSize {
    // This will be improved with context aware methods
    return this;
  }

  /// Get responsive value based on device type
  /// Useful for responsive spacing, sizes, etc.
  double responsiveValue({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return this; // Placeholder - needs context
  }
}
