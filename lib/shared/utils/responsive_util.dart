import 'package:flutter/material.dart';

class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
}

class ResponsiveUtil {
  static double _deviceWidth(BuildContext context) {
    final mediaQuery = MediaQuery.maybeOf(context);
    if (mediaQuery != null) {
      return mediaQuery.size.width;
    }

    final view = View.of(context);
    return view.physicalSize.width / view.devicePixelRatio;
  }

  static bool isMobile(BuildContext context) {
    return _deviceWidth(context) < ResponsiveBreakpoints.mobile;
  }

  static bool isTablet(BuildContext context) {
    final width = _deviceWidth(context);
    return width >= ResponsiveBreakpoints.mobile &&
        width < ResponsiveBreakpoints.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return _deviceWidth(context) >= ResponsiveBreakpoints.tablet;
  }

  static double maxContentWidth(BuildContext context) {
    final width = _deviceWidth(context);
    if (width >= ResponsiveBreakpoints.desktop) {
      return 1320;
    }
    if (width >= ResponsiveBreakpoints.tablet) {
      return 1120;
    }
    return width;
  }

  static double horizontalPadding(BuildContext context) {
    final width = _deviceWidth(context);
    if (width >= ResponsiveBreakpoints.desktop) {
      return 28;
    }
    if (width >= ResponsiveBreakpoints.tablet) {
      return 20;
    }
    return 16;
  }
}

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return mobile;
  }
}

class ResponsiveContent extends StatelessWidget {
  final Widget child;
  final bool addHorizontalPadding;

  const ResponsiveContent({
    super.key,
    required this.child,
    this.addHorizontalPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = ResponsiveUtil.maxContentWidth(context);
    final horizontal =
        addHorizontalPadding ? ResponsiveUtil.horizontalPadding(context) : 0.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: child,
        ),
      ),
    );
  }
}
