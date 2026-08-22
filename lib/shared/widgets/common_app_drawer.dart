import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/style/app_colors.dart';

class CommonAppDrawer extends StatelessWidget {
  const CommonAppDrawer({super.key});

  Widget drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      minLeadingWidth: 8,
      horizontalTitleGap: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.primary2.withOpacity(isDark ? 0.22 : 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 19,
          color: AppColors.primary2,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.white : AppColors.black1,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: isDark ? const Color(0xFF9D9D9D) : const Color(0xFF9CA3AF),
      ),
      onTap: () {
        Get.back();
        Get.toNamed(route);
      },
    );
  }

  Widget _sectionLabel(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 14, 6, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
          color: isDark ? const Color(0xFFC7C7C7) : AppColors.black2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: isDark ? const Color(0xFF121212) : AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1D1D1D) : AppColors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF313131)
                      : const Color(0xFFECECEC),
                ),
                boxShadow: [
                  if (!isDark)
                    const BoxShadow(
                      color: Color(0x12111111),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE27B49), AppColors.primary2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.person,
                        color: AppColors.white, size: 30),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/profile');
                    },
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ShopHub',
                            style: TextStyle(
                              color:
                                  isDark ? AppColors.white : AppColors.black1,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'customer@shophub.com',
                            style: TextStyle(
                              color: isDark
                                  ? const Color(0xFFB7B7B7)
                                  : AppColors.black2,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 2, 12, 12),
                children: [
                  _sectionLabel(context, 'SHOPPING'),
                  drawerItem(
                    context: context,
                    icon: Icons.home,
                    title: 'Home',
                    route: '/home',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.category,
                    title: 'Categories',
                    route: '/categories',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.grid_view,
                    title: 'Sub Categories',
                    route: '/subcategories',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.search,
                    title: 'Search',
                    route: '/search',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.shopping_bag,
                    title: 'Products',
                    route: '/products',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.favorite,
                    title: 'Wishlist',
                    route: '/wishlist',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.shopping_cart,
                    title: 'Cart',
                    route: '/cart',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.payment,
                    title: 'Checkout',
                    route: '/checkout',
                  ),
                  _sectionLabel(context, 'ACCOUNT'),
                  drawerItem(
                    context: context,
                    icon: Icons.location_on,
                    title: 'Address',
                    route: '/address',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.credit_card,
                    title: 'Payment',
                    route: '/payment',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.receipt_long,
                    title: 'My Orders',
                    route: '/myOrders',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.local_shipping,
                    title: 'Order Tracking',
                    route: '/orderTracking',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.assignment_return,
                    title: 'Returns',
                    route: '/returns',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.discount,
                    title: 'Coupons',
                    route: '/coupons',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.notifications,
                    title: 'Notifications',
                    route: '/notifications',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.chat,
                    title: 'Chat',
                    route: '/chat',
                  ),
                  _sectionLabel(context, 'SUPPORT'),
                  drawerItem(
                    context: context,
                    icon: Icons.help,
                    title: 'Help Center',
                    route: '/help',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.support_agent,
                    title: 'Support',
                    route: '/support',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.star,
                    title: 'Loyalty Points',
                    route: '/loyaltyPoints',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.card_giftcard,
                    title: 'Refer & Earn',
                    route: '/referAndEarn',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.history,
                    title: 'Recently Viewed',
                    route: '/recentlyViewed',
                  ),
                  const SizedBox(height: 6),
                  Divider(
                    height: 16,
                    color: isDark ? const Color(0xFF303030) : AppColors.divider,
                  ),
                  _sectionLabel(context, 'LEGAL & APP'),
                  drawerItem(
                    context: context,
                    icon: Icons.info,
                    title: 'About Us',
                    route: '/about',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    route: '/privacy',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.description,
                    title: 'Terms & Conditions',
                    route: '/terms',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.contact_mail,
                    title: 'Contact Us',
                    route: '/contact',
                  ),
                  drawerItem(
                    context: context,
                    icon: Icons.settings,
                    title: 'Settings',
                    route: '/settings',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
