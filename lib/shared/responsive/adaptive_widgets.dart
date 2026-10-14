import 'package:flutter/material.dart';
import 'responsive_config.dart';
import 'responsive_extension.dart';

/// Responsive container that adapts to screen size
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final bool centerContent;
  final BoxDecoration? decoration;

  const ResponsiveContainer({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.height,
    this.centerContent = false,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;

    // Default responsive padding
    final defaultPadding = EdgeInsets.all(screenSize.padding);
    final effectivePadding = padding ?? defaultPadding;

    // Default responsive border radius
    final effectiveRadius =
        borderRadius ?? BorderRadius.circular(screenSize.borderRadius);

    final effectiveDecoration = decoration ??
        BoxDecoration(
          color: backgroundColor,
          borderRadius: effectiveRadius,
        );

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: effectivePadding,
      decoration: effectiveDecoration,
      child: centerContent ? Center(child: child) : child,
    );
  }
}

/// Responsive grid that adjusts columns based on device
class ResponsiveGridView extends StatelessWidget {
  final int? columnsMobile;
  final int? columnsTablet;
  final int? columnsDesktop;
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final MainAxisAlignment childAlignment;

  const ResponsiveGridView({
    Key? key,
    this.columnsMobile,
    this.columnsTablet,
    this.columnsDesktop,
    required this.children,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.childAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;

    int columns;
    if (screenSize.isMobile) {
      columns = columnsMobile ?? ResponsiveConfig.gridColumnsMobile;
    } else if (screenSize.isTablet) {
      columns = columnsTablet ?? ResponsiveConfig.gridColumnsTablet;
    } else {
      columns = columnsDesktop ?? ResponsiveConfig.gridColumnsDesktop;
    }

    return GridView.count(
      crossAxisCount: columns,
      childAspectRatio: 1.0,
      padding: padding ?? EdgeInsets.all(screenSize.padding),
      physics: physics,
      shrinkWrap: shrinkWrap,
      mainAxisSpacing: runSpacing,
      crossAxisSpacing: spacing,
      children: children,
    );
  }
}

/// Responsive layout that switches between column and row based on device
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;

    if (screenSize.isDesktop && desktop != null) {
      return desktop!;
    } else if (screenSize.isTablet && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

/// Responsive flex layout (adaptive column/row)
class ResponsiveFlex extends StatelessWidget {
  final List<Widget> children;
  final Axis mobileDirection;
  final Axis tabletDirection;
  final Axis desktopDirection;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets? padding;

  const ResponsiveFlex({
    Key? key,
    required this.children,
    this.mobileDirection = Axis.vertical,
    this.tabletDirection = Axis.vertical,
    this.desktopDirection = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;

    Axis direction;
    if (screenSize.isDesktop) {
      direction = desktopDirection;
    } else if (screenSize.isTablet) {
      direction = tabletDirection;
    } else {
      direction = mobileDirection;
    }

    final content = Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );

    if (padding != null) {
      return Padding(padding: padding!, child: content);
    }
    return content;
  }
}

/// Responsive padding widget
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final double? mobilePadding;
  final double? tabletPadding;
  final double? desktopPadding;
  final EdgeInsets Function(ScreenSize)? customPadding;

  const ResponsivePadding({
    Key? key,
    required this.child,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.customPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;

    EdgeInsets padding;
    if (customPadding != null) {
      padding = customPadding!(screenSize);
    } else {
      final effectivePadding = screenSize.isMobile
          ? mobilePadding ?? ResponsiveConfig.paddingMobile
          : screenSize.isTablet
              ? tabletPadding ?? ResponsiveConfig.paddingTablet
              : desktopPadding ?? ResponsiveConfig.paddingDesktop;
      padding = EdgeInsets.all(effectivePadding);
    }

    return Padding(padding: padding, child: child);
  }
}

/// Responsive spacer
class ResponsiveSpacer extends StatelessWidget {
  final double mobileFlex;
  final double tabletFlex;
  final double desktopFlex;

  const ResponsiveSpacer({
    Key? key,
    this.mobileFlex = 1.0,
    this.tabletFlex = 1.0,
    this.desktopFlex = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;

    final flex = screenSize.isMobile
        ? mobileFlex
        : screenSize.isTablet
            ? tabletFlex
            : desktopFlex;

    return Spacer(flex: flex.toInt());
  }
}
