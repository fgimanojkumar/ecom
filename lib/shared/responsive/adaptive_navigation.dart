import 'package:flutter/material.dart';
import '../style/app_colors.dart';
import 'responsive_extension.dart';

/// Adaptive navigation that changes based on screen size
/// Mobile: Bottom Navigation Bar
/// Tablet: Side Navigation + Top Bar
/// Desktop: Top Navigation Bar with drawer
class AdaptiveNavigation extends StatelessWidget {
  final List<NavItem> items;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Widget? logo;
  final String? appTitle;

  const AdaptiveNavigation({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemTapped,
    this.logo,
    this.appTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return _buildMobileBottomNav(context);
    } else if (context.isTablet) {
      return _buildTabletSideNav(context);
    } else {
      return _buildDesktopTopNav(context);
    }
  }

  Widget _buildMobileBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary1,
      unselectedItemColor: AppColors.black2,
      type: BottomNavigationBarType.fixed,
      items: items
          .map((item) => BottomNavigationBarItem(
                icon: item.icon,
                label: item.label,
              ))
          .toList(),
    );
  }

  Widget _buildTabletSideNav(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,
      backgroundColor: AppColors.white,
      labelType: NavigationRailLabelType.selected,
      destinations: items
          .map((item) => NavigationRailDestination(
                icon: item.icon,
                label: Text(item.label),
              ))
          .toList(),
    );
  }

  Widget _buildDesktopTopNav(BuildContext context) {
    return Container(
      color: AppColors.appBarColor,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding * 2,
        vertical: context.responsivePadding,
      ),
      child: Row(
        children: [
          if (logo != null) ...[
            SizedBox(
              width: 40,
              height: 40,
              child: logo,
            ),
            SizedBox(width: context.responsivePadding),
          ],
          if (appTitle != null)
            Text(
              appTitle!,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          const Spacer(),
          Row(
            children: List.generate(
              items.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsivePadding,
                ),
                child: GestureDetector(
                  onTap: () => onItemTapped(index),
                  child: Column(
                    children: [
                      items[index].icon,
                      SizedBox(height: 4),
                      Text(
                        items[index].label,
                        style: TextStyle(
                          color: selectedIndex == index
                              ? AppColors.white
                              : AppColors.white.withOpacity(0.7),
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Navigation item data class
class NavItem {
  final Widget icon;
  final String label;
  final String route;

  NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

/// Responsive app bar that adapts to screen size
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onMenuPressed;
  final bool showBackButton;
  final Color backgroundColor;
  final Color textColor;

  const ResponsiveAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.onMenuPressed,
    this.showBackButton = false,
    this.backgroundColor = AppColors.primary1,
    this.textColor = const Color(0xFFFFFFFF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: context.isMobile ? 18 : 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: backgroundColor,
      elevation: 2,
      leading:
          leading ?? (showBackButton ? BackButton(color: textColor) : null),
      actions: actions,
      centerTitle: context.isMobile ? false : true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Responsive drawer widget
class ResponsiveDrawer extends StatelessWidget {
  final List<DrawerItem> items;
  final String? header;
  final Widget? headerWidget;
  final Function(String) onItemTapped;
  final String? selectedRoute;

  const ResponsiveDrawer({
    Key? key,
    required this.items,
    this.header,
    this.headerWidget,
    required this.onItemTapped,
    this.selectedRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (headerWidget != null)
            headerWidget!
          else if (header != null)
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.appBarColor,
              ),
              child: Text(
                header!,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ...items.map((item) {
            final isSelected = selectedRoute == item.route;
            return ListTile(
              leading: item.icon,
              title: Text(item.label),
              selected: isSelected,
              selectedTileColor: AppColors.primary1.withOpacity(0.1),
              onTap: () {
                onItemTapped(item.route);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

/// Drawer item data class
class DrawerItem {
  final Widget icon;
  final String label;
  final String route;

  DrawerItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
