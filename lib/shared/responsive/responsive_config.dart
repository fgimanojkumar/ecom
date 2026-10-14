/// Responsive configuration and breakpoints for multi-platform app
/// Mobile-first approach: Mobile → Tablet → Desktop

class ResponsiveConfig {
  ResponsiveConfig._();

  /// Screen size breakpoints
  static const double mobileBreakpoint = 480; // Small phones
  static const double mobileMaxWidth = 599; // Up to large phones
  static const double tabletBreakpoint = 600; // Tablets start here
  static const double tabletMaxWidth = 1199; // Large tablets
  static const double desktopBreakpoint = 1200; // Desktop screens
  static const double desktopMaxWidth = 1600; // Large desktop
  static const double ultraDesktopBreakpoint = 1601; // Ultra-wide screens

  /// Device type enum
  static const String mobile = 'mobile';
  static const String tablet = 'tablet';
  static const String desktop = 'desktop';

  /// Responsive grid columns
  static const int gridColumnsMobile = 2;
  static const int gridColumnsTablet = 3;
  static const int gridColumnsDesktop = 4;
  static const int gridColumnsUltra = 5;

  /// Max content width for desktop
  static const double maxContentWidth = 1400;

  /// Padding scales by device
  static const double paddingMobile = 12.0;
  static const double paddingTablet = 16.0;
  static const double paddingDesktop = 24.0;

  /// Border radius scales
  static const double radiusMobile = 8.0;
  static const double radiusTablet = 12.0;
  static const double radiusDesktop = 16.0;

  /// Icon sizes
  static const double iconSizeMobile = 20.0;
  static const double iconSizeTablet = 24.0;
  static const double iconSizeDesktop = 28.0;
}

/// Screen size info class
class ScreenSize {
  final double width;
  final double height;
  final String deviceType; // mobile, tablet, desktop
  final bool isLandscape;
  final double aspectRatio;

  ScreenSize({
    required this.width,
    required this.height,
    required this.deviceType,
    required this.isLandscape,
  }) : aspectRatio = width / height;

  bool get isMobile => deviceType == ResponsiveConfig.mobile;
  bool get isTablet => deviceType == ResponsiveConfig.tablet;
  bool get isDesktop => deviceType == ResponsiveConfig.desktop;

  /// Safe area consideration
  double get safeWidth => width;
  double get safeHeight => height;

  /// Get columns based on device
  int get gridColumns {
    if (isMobile) return ResponsiveConfig.gridColumnsMobile;
    if (isTablet) return ResponsiveConfig.gridColumnsTablet;
    return ResponsiveConfig.gridColumnsDesktop;
  }

  /// Get padding based on device
  double get padding {
    if (isMobile) return ResponsiveConfig.paddingMobile;
    if (isTablet) return ResponsiveConfig.paddingTablet;
    return ResponsiveConfig.paddingDesktop;
  }

  /// Get border radius based on device
  double get borderRadius {
    if (isMobile) return ResponsiveConfig.radiusMobile;
    if (isTablet) return ResponsiveConfig.radiusTablet;
    return ResponsiveConfig.radiusDesktop;
  }

  /// Get icon size based on device
  double get iconSize {
    if (isMobile) return ResponsiveConfig.iconSizeMobile;
    if (isTablet) return ResponsiveConfig.iconSizeTablet;
    return ResponsiveConfig.iconSizeDesktop;
  }

  @override
  String toString() =>
      'ScreenSize($width x $height, $deviceType, ${isLandscape ? 'landscape' : 'portrait'})';
}

/// Helper to determine device type based on width
String getDeviceType(double width) {
  if (width < ResponsiveConfig.tabletBreakpoint) {
    return ResponsiveConfig.mobile;
  } else if (width < ResponsiveConfig.desktopBreakpoint) {
    return ResponsiveConfig.tablet;
  } else {
    return ResponsiveConfig.desktop;
  }
}
