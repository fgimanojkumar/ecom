import 'package:flutter/material.dart';
import '../../shared/style/app_colors.dart';
import '../utils/responsive_util.dart';

class PremiumBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<BottomBarItem> items;

  const PremiumBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtil.isDesktop(context);
    final navMaxWidth = ResponsiveUtil.maxContentWidth(context);

    return SafeArea(
      top: false,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: isDesktop ? navMaxWidth : double.infinity),
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEDEDED)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  backgroundColor: AppColors.white,
                  height: 70,
                  indicatorColor: AppColors.primary2.withOpacity(0.14),
                  elevation: 0,
                  labelTextStyle: WidgetStateProperty.resolveWith((states) {
                    final isSelected = states.contains(WidgetState.selected);
                    return TextStyle(
                      fontSize: 11,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? AppColors.primary2 : AppColors.black2,
                    );
                  }),
                ),
                child: NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onTap,
                  destinations: items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isSelected = index == selectedIndex;

                    return NavigationDestination(
                      icon: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary2.withOpacity(0.08)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              item.icon,
                              size: 22,
                              color: isSelected
                                  ? AppColors.primary2
                                  : AppColors.black2,
                            ),
                            if (item.badgeCount > 0)
                              Positioned(
                                right: -8,
                                top: -8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.error,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    item.badgeCount > 99
                                        ? '99+'
                                        : item.badgeCount.toString(),
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      selectedIcon:
                          Icon(item.icon, size: 22, color: AppColors.primary2),
                      label: item.label,
                      tooltip: item.label,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBarItem {
  final IconData icon;
  final String label;
  final int badgeCount;

  BottomBarItem({
    required this.icon,
    required this.label,
    this.badgeCount = 0,
  });
}
