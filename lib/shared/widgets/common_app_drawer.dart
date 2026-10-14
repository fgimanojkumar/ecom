import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';

/// Dark sidebar nav - mirrors hgfedcba's admin-sidebar (dark #111827 bg,
/// pill nav links, icon chips, user block + status footer).
class CommonAppDrawer extends StatelessWidget {
  const CommonAppDrawer({super.key, this.panelMode = false});

  final bool panelMode;

  Widget _navLink({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
  }) {
    final isActive = Get.currentRoute == route;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: isActive ? AppColors.sidebarSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Get.back();
            Get.toNamed(route);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.sidebarIconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon,
                      size: 15,
                      color:
                          isActive ? AppColors.white : const Color(0xFFBFDBFE)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isActive ? AppColors.white : AppColors.sidebarText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
          color: Color(0xFF9CA3AF),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final drawerWidth =
        kIsWeb && screenWidth >= 1024 ? screenWidth * 0.4 : screenWidth * 0.8;

    final drawerContent = SafeArea(
      child: Column(
        children: [
          // Sidebar header (brand-mark)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF0F766E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.grid_view_rounded,
                      color: AppColors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Baba Ecom',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Seller',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: Colors.white.withOpacity(0.08)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              children: [
                _sectionLabel('SELLER'),
                _navLink(
                  context: context,
                  icon: Icons.dashboard_rounded,
                  title: 'Dashboard',
                  route: '/home',
                ),
                _navLink(
                  context: context,
                  icon: Icons.receipt_long,
                  title: 'Orders',
                  route: '/myOrders',
                ),
                _navLink(
                  context: context,
                  icon: Icons.inventory_2_rounded,
                  title: 'Products',
                  route: '/products',
                ),
                _navLink(
                  context: context,
                  icon: Icons.category_rounded,
                  title: 'Categories',
                  route: '/categories',
                ),
                _navLink(
                  context: context,
                  icon: Icons.reviews_rounded,
                  title: 'Reviews & Ratings',
                  route: '/reviews',
                ),
                _navLink(
                  context: context,
                  icon: Icons.assignment_return_rounded,
                  title: 'Product Returns',
                  route: '/returns',
                ),
                _navLink(
                  context: context,
                  icon: Icons.local_offer_rounded,
                  title: 'Offers & Coupons',
                  route: '/offers',
                ),
                _navLink(
                  context: context,
                  icon: Icons.people_alt_rounded,
                  title: 'Customers',
                  route: '/customers',
                ),
                _navLink(
                  context: context,
                  icon: Icons.local_shipping_rounded,
                  title: 'Shipping & Logistics',
                  route: '/shipping',
                ),
                _navLink(
                  context: context,
                  icon: Icons.account_balance_wallet_rounded,
                  title: 'Payments & Settlements',
                  route: '/payments',
                ),
                _navLink(
                  context: context,
                  icon: Icons.account_balance_rounded,
                  title: 'Bank Details',
                  route: '/bankDetails',
                ),
                _navLink(
                  context: context,
                  icon: Icons.notifications,
                  title: 'Notifications',
                  route: '/notifications',
                ),
                _sectionLabel('ACCOUNT'),
                _navLink(
                  context: context,
                  icon: Icons.storefront,
                  title: 'Profile',
                  route: '/profile',
                ),
                _navLink(
                  context: context,
                  icon: Icons.settings,
                  title: 'Settings',
                  route: '/settings',
                ),
                _sectionLabel('SUPPORT'),
                _navLink(
                  context: context,
                  icon: Icons.help,
                  title: 'Help Center',
                  route: '/help',
                ),
                _navLink(
                  context: context,
                  icon: Icons.support_agent,
                  title: 'Support',
                  route: '/support',
                ),
                _sectionLabel('LEGAL & APP'),
                _navLink(
                  context: context,
                  icon: Icons.info,
                  title: 'About Us',
                  route: '/about',
                ),
                _navLink(
                  context: context,
                  icon: Icons.privacy_tip,
                  title: 'Privacy Policy',
                  route: '/privacy',
                ),
                _navLink(
                  context: context,
                  icon: Icons.description,
                  title: 'Terms & Conditions',
                  route: '/terms',
                ),
                _navLink(
                  context: context,
                  icon: Icons.contact_mail,
                  title: 'Contact Us',
                  route: '/contact',
                ),
              ],
            ),
          ),
          // sidebar-user block
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.sidebarSoft,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF53E9B9), width: 3),
                  ),
                  child: const Icon(Icons.person,
                      color: AppColors.white, size: 22),
                ),
                const SizedBox(height: 6),
                const Text('Seller',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const Text('Seller Workspace',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11.5)),
              ],
            ),
          ),
          // sidebar-footer status
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Row(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'System running smoothly',
                  style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (panelMode) {
      return Material(
        color: AppColors.sidebarBg,
        child: SizedBox(width: drawerWidth, child: drawerContent),
      );
    }

    return Drawer(
      width: drawerWidth,
      backgroundColor: AppColors.sidebarBg,
      child: drawerContent,
    );
  }
}
