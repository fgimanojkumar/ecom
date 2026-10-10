import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/style/app_text_style.dart';
import '../../../shared/widgets/app_update_dialog.dart';
import '../../../shared/widgets/common_app_drawer.dart';
import '../../../shared/widgets/emergency_alert_popup.dart';
import '../../../shared/widgets/exit_app_pop_up.dart';
import '../../../shared/widgets/premium_bottom_bar.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../../../shared/widgets/premium_category_card.dart';
import '../../../shared/widgets/premium_product_card.dart';
import '../../address/controller/address_controller.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.ensureInitialized();
    final cartController = CartController.ensureInitialized();
    final banners = controller.banners;
    final hasBanners = banners.isNotEmpty;
    final isWeb = kIsWeb;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTabletLayout = screenWidth >= 600 && screenWidth < 1024;
    final isWideLayout = screenWidth >= 1024;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        exitApp(context);
      },
      child: Scaffold(
        drawer: const CommonAppDrawer(),
        backgroundColor: Colors.white,
        appBar: PremiumAppBar(
          title: 'home',
          showBackButton: false,
        ),
        body: SafeArea(
          bottom: false,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async =>
                          Future.delayed(const Duration(seconds: 1)),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                          isWideLayout ? 28 : 0,
                          8,
                          isWideLayout ? 28 : 0,
                          isWeb ? 24 : 100,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isWideLayout ? 1440 : double.infinity,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 12),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: OutlinedButton.icon(
                                          onPressed: () =>
                                              showEmergencyAlertDialog(context),
                                          icon: const Icon(
                                              Icons.warning_amber_rounded,
                                              color: AppColors.error),
                                          label: const Text(
                                              'Test Emergency Alert'),
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: AppColors.error,
                                            side: const BorderSide(
                                                color: AppColors.error),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () =>
                                              AppUpdateDialog.showTestDialog(
                                                  force: false),
                                          icon: const Icon(Icons.system_update),
                                          label:
                                              const Text('Test Update Dialog'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary1,
                                            foregroundColor: AppColors.white,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    0,
                                    16,
                                    12,
                                  ),
                                  child: Obx(() {
                                    final address =
                                        addressController.selectedAddress;
                                    final addressDetails = [
                                      address?['street'],
                                      address?['city'],
                                      address?['state'],
                                      address?['pincode'],
                                    ]
                                        .where((part) =>
                                            part != null &&
                                            part.toString().trim().isNotEmpty)
                                        .map((part) => part.toString().trim())
                                        .join(', ');

                                    return Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        // borderRadius: BorderRadius.circular(12),
                                        // border: Border.all(
                                        //   color: AppColors.white2,
                                        // ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: AppColors.primary1
                                                  .withValues(alpha: 0.08),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: const Icon(
                                              Icons.location_on_outlined,
                                              color: AppColors.primary1,
                                              size: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              addressDetails.isEmpty
                                                  ? 'Choose an address'
                                                  : addressDetails,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: AppColors.black1,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          TextButton(
                                            onPressed: () =>
                                                Get.toNamed('/address'),
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6,
                                              ),
                                              minimumSize: const Size(0, 36),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: const Text(
                                              'Change',
                                              style: TextStyle(fontSize: 11),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                                // --- [1] BANNER SLIDER START -------------------------
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        isWideLayout || isTabletLayout ? 0 : 12,
                                  ),
                                  child: SizedBox(
                                    height: isWideLayout
                                        ? 320
                                        : isTabletLayout
                                            ? 250
                                            : 168,
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.black
                                                    .withOpacity(0.12),
                                                blurRadius: 20,
                                                offset: const Offset(0, 10),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            child: hasBanners
                                                ? PageView.builder(
                                                    controller: controller
                                                        .bannerPageController,
                                                    itemCount: banners.length,
                                                    onPageChanged: (i) =>
                                                        controller
                                                            .currentBannerIndex
                                                            .value = i,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final banner =
                                                          banners[index];
                                                      final bannerTitle =
                                                          (banner['title'] ??
                                                                  '')
                                                              .toString();
                                                      final bannerSubtitle =
                                                          (banner['subtitle'] ??
                                                                  '')
                                                              .toString();
                                                      final bannerImage =
                                                          (banner['image'] ??
                                                                  '')
                                                              .toString();
                                                      final color1 =
                                                          banner['color1']
                                                                  is Color
                                                              ? banner['color1']
                                                                  as Color
                                                              : const Color(
                                                                  0xFFD884A7);
                                                      final color2 =
                                                          banner['color2']
                                                                  is Color
                                                              ? banner['color2']
                                                                  as Color
                                                              : const Color(
                                                                  0xFFC66D98);

                                                      return Stack(
                                                        fit: StackFit.expand,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                                colors: [
                                                                  color1,
                                                                  color2,
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          if (bannerImage
                                                              .isNotEmpty)
                                                            Image.network(
                                                              bannerImage,
                                                              fit: BoxFit.cover,
                                                              alignment: isWideLayout
                                                                  ? Alignment
                                                                      .centerRight
                                                                  : Alignment
                                                                      .center,
                                                              errorBuilder: (_,
                                                                      __,
                                                                      ___) =>
                                                                  const SizedBox
                                                                      .shrink(),
                                                            ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                                colors: [
                                                                  AppColors
                                                                      .black
                                                                      .withOpacity(
                                                                          .08),
                                                                  AppColors
                                                                      .black
                                                                      .withOpacity(
                                                                          .52),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: isWideLayout
                                                                ? 40
                                                                : isTabletLayout
                                                                    ? 28
                                                                    : 16,
                                                            top: isWideLayout
                                                                ? 36
                                                                : isTabletLayout
                                                                    ? 26
                                                                    : 18,
                                                            right: 16,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                if (bannerTitle
                                                                    .isNotEmpty) ...[
                                                                  ConstrainedBox(
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      maxWidth: isWideLayout
                                                                          ? 500
                                                                          : isTabletLayout
                                                                              ? 380
                                                                              : 260,
                                                                    ),
                                                                    child: Text(
                                                                      bannerTitle,
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .white,
                                                                        fontSize: isWideLayout
                                                                            ? 34
                                                                            : isTabletLayout
                                                                                ? 28
                                                                                : 21,
                                                                        height:
                                                                            1.15,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          8),
                                                                ],
                                                                Text(
                                                                  bannerSubtitle,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .white
                                                                        .withOpacity(
                                                                            .9),
                                                                    fontSize: isWideLayout
                                                                        ? 15
                                                                        : isTabletLayout
                                                                            ? 14
                                                                            : 12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 12),
                                                                ElevatedButton(
                                                                  onPressed: () =>
                                                                      Get.toNamed(
                                                                          '/home'),
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .white,
                                                                    foregroundColor:
                                                                        AppColors
                                                                            .primary1,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          9,
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                    ),
                                                                    elevation:
                                                                        0,
                                                                    minimumSize:
                                                                        const Size(
                                                                            0,
                                                                            34),
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    'Shop Now',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    color:
                                                        const Color(0xFFD884A7),
                                                  ),
                                          ),
                                        ),
                                        if (banners.length > 1)
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 10,
                                            child: Obx(
                                              () => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                  banners.length,
                                                  (i) {
                                                    final isActive = controller
                                                            .currentBannerIndex
                                                            .value ==
                                                        i;
                                                    return AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 280),
                                                      curve: Curves.easeOut,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 3,
                                                      ),
                                                      width: isActive ? 20 : 6,
                                                      height: 6,
                                                      decoration: BoxDecoration(
                                                        color: isActive
                                                            ? AppColors.primary1
                                                            : const Color(
                                                                0xFFD6D6D6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                // --- [1] BANNER SLIDER END ---------------------------

                                // Emergency message below slider � controlled by showEmergencyBanner
                                Obx(() => controller.showEmergencyBanner.value
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 10, 16, 0),
                                        child: _EmergencyBanner(
                                          message:
                                              controller.emergencyMessage.value,
                                          onTap: () => _showHomeInfoSheet(
                                            context,
                                            title: 'Important update',
                                            message: controller
                                                .emergencyMessage.value,
                                            isUrgent: true,
                                          ),
                                          onClose: () => controller
                                              .showEmergencyBanner
                                              .value = false,
                                        ),
                                      )
                                    : const SizedBox.shrink()),

                                const SizedBox(height: 12),

                                // --- [3] CATEGORIES START ----------------------------
                                _SectionContainer(
                                  backgroundColor: const Color(0xFFF1F9FF),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _SectionHeader(
                                        title: 'Categories',
                                        actionLabel: 'See All',
                                        onActionTap: () =>
                                            Get.toNamed('/categories'),
                                      ),
                                      const SizedBox(height: 12),
                                      Obx(
                                        () => SizedBox(
                                          height: 110,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                controller.categories.length,
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(width: 12),
                                            itemBuilder: (context, index) {
                                              final cat =
                                                  controller.categories[index];
                                              return SizedBox(
                                                width: 90,
                                                child: PremiumCategoryCard(
                                                  name: (cat['name'] ?? '')
                                                      .toString(),
                                                  image: (cat['image'] ?? '')
                                                      .toString(),
                                                  icon: Icons.category.codePoint
                                                      .toString(),
                                                  onTap: () {
                                                    controller
                                                        .selectCategory(index);
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // --- [3] CATEGORIES END ------------------------------

                                const SizedBox(height: 16),
                                // --- [2] PROMO OFFERS SECTION START/END --------------
                                _PromoOffersSection(
                                  promos: controller.promos.toList(),
                                ),
                                const SizedBox(height: 16),

                                // --- [5] TOP PRODUCTS START/END ----------------------
                                _ProductsStripSection(
                                  title: 'Top Products',
                                  backgroundColor: const Color(0xFFEEFCEF),
                                  actionLabel: 'View All',
                                  onViewAllTap: () => Get.toNamed('/home'),
                                  products: controller.topProducts,
                                  onProductTap: (id) =>
                                      controller.onProductTap(id),
                                  onWishlistToggleById: (id) {
                                    final idx = controller.featuredProducts
                                        .indexWhere((item) =>
                                            item['id'].toString() == id);
                                    if (idx >= 0) {
                                      controller.toggleWishlist(idx);
                                    }
                                  },
                                ),
                                const SizedBox(height: 22),
                                // --- [NEW] DEAL OF THE DAY ---------------------------
                                if (controller.featuredProducts.isNotEmpty)
                                  _DealOfTheDaySection(
                                    product: controller.featuredProducts.first,
                                    onTap: () => controller.onProductTap(
                                      controller.featuredProducts.first['id']
                                              ?.toString() ??
                                          '',
                                    ),
                                  ),
                                const SizedBox(height: 22),
                                // --- [6] RECENT VIEWED PRODUCTS START/END ------------
                                _ProductsStripSection(
                                  title: 'Recent Viewed Products',
                                  backgroundColor: const Color(0xFFF5F3FF),
                                  actionLabel: 'See All',
                                  onViewAllTap: () => Get.toNamed('/home'),
                                  products: controller.recentViewedProducts,
                                  onProductTap: (id) =>
                                      controller.onProductTap(id),
                                  onWishlistToggleById: (id) {
                                    final idx = controller.featuredProducts
                                        .indexWhere((item) =>
                                            item['id'].toString() == id);
                                    if (idx >= 0) {
                                      controller.toggleWishlist(idx);
                                    }
                                  },
                                ),
                                const SizedBox(height: 22),
                                // --- [7] TOP RATED PRODUCTS START/END ----------------
                                _ProductsStripSection(
                                  title: 'Top Rated Products',
                                  backgroundColor: const Color(0xFFEFF7FF),
                                  actionLabel: 'View All',
                                  onViewAllTap: () => Get.toNamed('/home'),
                                  products: controller.topRatedProducts,
                                  onProductTap: (id) =>
                                      controller.onProductTap(id),
                                  onWishlistToggleById: (id) {
                                    final idx = controller.featuredProducts
                                        .indexWhere((item) =>
                                            item['id'].toString() == id);
                                    if (idx >= 0) {
                                      controller.toggleWishlist(idx);
                                    }
                                  },
                                ),
                                const SizedBox(height: 22),
                                // --- [NEW] TOP BRANDS --------------------------------
                                const _BrandRowSection(),
                                const SizedBox(height: 22),
                                // --- [8] HOT OFFERS START/END ------------------------
                                _OffersSection(
                                    offers: controller.offers.toList()),
                                const SizedBox(height: 22),
                                // --- [9] SHOPPING BENEFITS START/END -----------------
                                const _HomeBenefitsSection(),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (!isWeb)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => PremiumBottomBar(
                      selectedIndex: 0,
                      onTap: (index) {
                        switch (index) {
                          case 0:
                            break;
                          case 1:
                            Get.toNamed('/cart');
                            break;
                          case 2:
                            Get.toNamed('/profile');
                            break;
                        }
                      },
                      items: [
                        BottomBarItem(
                          icon: Icons.home_filled,
                          label: 'Home',
                        ),
                        BottomBarItem(
                          icon: Icons.shopping_cart,
                          label: 'Cart',
                          badgeCount: cartController.itemCount,
                        ),
                        BottomBarItem(
                          icon: Icons.person,
                          label: 'Profile',
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showHomeInfoSheet(
  BuildContext context, {
  required String title,
  required String message,
  bool isUrgent = false,
}) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.75,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.white2,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      tooltip: 'Close information',
                      onPressed: () => Navigator.of(sheetContext).pop(),
                      constraints:
                          const BoxConstraints.tightFor(width: 40, height: 40),
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isUrgent
                        ? AppColors.warning.withOpacity(0.12)
                        : AppColors.primary1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    isUrgent
                        ? Icons.warning_amber_rounded
                        : Icons.info_outline_rounded,
                    color: isUrgent ? AppColors.warning : AppColors.primary1,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.black1,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'resources/images/login_img.png',
                width: double.infinity,
                height: 128,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(
                color: AppColors.black2,
                fontSize: 15,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(sheetContext).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary1,
                  foregroundColor: AppColors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Got it'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _EmergencyBanner extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  final VoidCallback onClose;
  const _EmergencyBanner({
    required this.message,
    required this.onTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.fromLTRB(12, 7, 6, 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 237, 185).withOpacity(0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(255, 248, 234, 171).withOpacity(0.55),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Color.fromARGB(255, 248, 173, 10),
                size: 15,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 241, 177, 0),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onClose,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.close_rounded,
                    color: Color.fromARGB(255, 71, 71, 71),
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductsStripSection extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final String actionLabel;
  final VoidCallback onViewAllTap;
  final List<Map<String, dynamic>> products;
  final ValueChanged<String> onProductTap;
  final ValueChanged<String> onWishlistToggleById;

  const _ProductsStripSection({
    required this.title,
    required this.backgroundColor,
    required this.actionLabel,
    required this.onViewAllTap,
    required this.products,
    required this.onProductTap,
    required this.onWishlistToggleById,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width >= 1200
        ? 230.0
        : width >= 900
            ? 205.0
            : 178.0;
    final listHeight = width < 600 ? 430.0 : 420.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionContainer(
          backgroundColor: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(
                title: title,
                actionLabel: actionLabel,
                onActionTap: onViewAllTap,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: listHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final id = product['id'].toString();
                    final name = (product['name'] ?? '').toString();
                    final image = (product['image'] ?? '').toString();
                    final price = ((product['price'] as num?) ?? 0).toDouble();
                    final originalPrice =
                        ((product['originalPrice'] as num?) ?? 0).toDouble();
                    final rating =
                        ((product['rating'] as num?) ?? 0).toDouble();
                    final reviewCount =
                        ((product['reviewCount'] as num?) ?? 0).toInt();
                    return SizedBox(
                      width: cardWidth,
                      child: PremiumProductCard(
                        id: id,
                        name: name,
                        image: image,
                        price: price,
                        originalPrice: originalPrice,
                        rating: rating,
                        reviewCount: reviewCount,
                        cardHeight: 400,
                        isWishlisted: product['isWishlisted'] == true,
                        isSponsored: product['isSponsored'] == true,
                        lowestPrice30Days:
                            (product['lowestPrice30Days'] as num?)?.toDouble(),
                        onTap: () => onProductTap(id),
                        onAddToCart: () => CartController.ensureInitialized()
                            .addMapProductToCart(product),
                        onWishlistToggle: () => onWishlistToggleById(id),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeBenefitsSection extends StatelessWidget {
  const _HomeBenefitsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionContainer(
          backgroundColor: const Color(0xFFFFF2F6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(
                title: 'Shopping Benefits',
                actionLabel: 'See All',
                onActionTap: () => Get.toNamed('/home'),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(
                    child: _BenefitTile(
                      icon: Icons.local_shipping_outlined,
                      title: 'Shipping Fee',
                      subtitle: 'Only Rs 49',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _BenefitTile(
                      icon: Icons.restart_alt,
                      title: 'Easy Return',
                      subtitle: '7-day return',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _BenefitTile(
                      icon: Icons.verified_user_outlined,
                      title: 'Secure Pay',
                      subtitle: '100% protected',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const _SectionContainer({
    required this.child,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      color: backgroundColor,
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onActionTap;

  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.fs12Black600().copyWith(
            fontSize: isMobile ? 18 : 16,
          ),
        ),
        TextButton(
          onPressed: onActionTap,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            actionLabel,
            style: AppTextStyle.cardTitleStyle().copyWith(
              color: AppColors.primary2,
              fontSize: isMobile ? 14 : 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _OffersSection extends StatelessWidget {
  final List<Map<String, dynamic>> offers;
  const _OffersSection({required this.offers});

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      backgroundColor: const Color(0xFFFFF9E8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'Hot Offers',
            actionLabel: 'See All',
            onActionTap: () => Get.toNamed('/specialOffers'),
          ),
          const SizedBox(height: 12),
          ...offers.map(
            (offer) => _OfferCard(
              offer: offer,
              onTap: () => Get.toNamed(offer['route']?.toString() ?? '/home'),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final Map<String, dynamic> offer;
  final VoidCallback? onTap;
  const _OfferCard({required this.offer, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = offer['colors'] as List<Color>;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: const BoxConstraints(minHeight: 96),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.32),
              blurRadius: 18,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -22,
              top: -22,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              right: 22,
              bottom: -18,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      offer['icon'] as IconData,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          offer['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          offer['subtitle'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.22),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.45),
                            ),
                          ),
                          child: Text(
                            offer['code'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          offer['discount'] as String,
                          style: TextStyle(
                            color: colors[0],
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'OFF',
                          style: TextStyle(
                            color: colors[0].withOpacity(0.75),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
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

class _PromoOffersSection extends StatefulWidget {
  final List<Map<String, dynamic>> promos;
  const _PromoOffersSection({required this.promos});

  @override
  State<_PromoOffersSection> createState() => _PromoOffersSectionState();
}

class _PromoOffersSectionState extends State<_PromoOffersSection>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _shimmerController;
  late final AnimationController _pulseController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final next = (_currentPage + 1) % widget.promos.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _shimmerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 130,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.promos.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, index) {
                final promo = widget.promos[index];
                final colors = promo['gradient'] as List<Color>;
                final accent = promo['accent'] as Color;
                return AnimatedBuilder(
                  animation: Listenable.merge(
                    [_shimmerController, _pulseController],
                  ),
                  builder: (context, _) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: colors,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: colors[0].withOpacity(
                              0.28 + _pulseController.value * 0.20,
                            ),
                            blurRadius: 16 + _pulseController.value * 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        children: [
                          Positioned(
                            right: -24,
                            top: -24,
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.09),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 40,
                            bottom: -28,
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.06),
                              ),
                            ),
                          ),
                          // Moving shimmer sweep
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment(
                                    -1.8 + _shimmerController.value * 4.2,
                                    -0.4,
                                  ),
                                  end: Alignment(
                                    -0.7 + _shimmerController.value * 4.2,
                                    0.4,
                                  ),
                                  colors: [
                                    Colors.white.withOpacity(0.0),
                                    Colors.white.withOpacity(0.11),
                                    Colors.white.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: accent.withOpacity(0.25),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: accent.withOpacity(0.65),
                                          ),
                                        ),
                                        child: Text(
                                          promo['tag'] as String,
                                          style: TextStyle(
                                            color: accent,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        promo['title'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          height: 1.15,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        promo['subtitle'] as String,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.82),
                                          fontSize: 11,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      GestureDetector(
                                        onTap: () => Get.toNamed(
                                          promo['route']?.toString() ?? '/home',
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'Shop Now ?',
                                            style: TextStyle(
                                              color: colors[0],
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Pulsing discount badge
                                Transform.rotate(
                                  angle: 0.08,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withOpacity(
                                          0.30 + _pulseController.value * 0.40,
                                        ),
                                        width: 2,
                                      ),
                                    ),
                                    child: Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.18),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${promo['discount']}%',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                              height: 1.0,
                                            ),
                                          ),
                                          Text(
                                            'OFF',
                                            style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.85),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.promos.length, (i) {
              final isActive = _currentPage == i;
              final activeColor =
                  (widget.promos[i]['gradient'] as List<Color>)[0];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOut,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isActive ? activeColor : const Color(0xFFD6D6D6),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// --- Flash Sale Section ---------------------------------------
class _FlashSaleSection extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final ValueChanged<String> onProductTap;
  const _FlashSaleSection({
    required this.products,
    required this.onProductTap,
  });

  @override
  State<_FlashSaleSection> createState() => _FlashSaleSectionState();
}

class _FlashSaleSectionState extends State<_FlashSaleSection> {
  late Timer _timer;
  int _secondsLeft = 2 * 3600 + 34 * 60 + 15;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_secondsLeft > 0) setState(() => _secondsLeft--);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final h = _pad(_secondsLeft ~/ 3600);
    final m = _pad((_secondsLeft % 3600) ~/ 60);
    final s = _pad(_secondsLeft % 60);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final cardWidth = width >= 1200
        ? 230.0
        : width >= 900
            ? 205.0
            : 178.0;
    final listHeight = isMobile ? 430.0 : 420.0;

    return _SectionContainer(
      backgroundColor: const Color(0xFFFFF3F0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF4500), Color(0xFFFF6B35)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt_rounded, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'Flash Sale',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 15 : 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _TimerBox(value: h),
                    const _TimerColon(),
                    _TimerBox(value: m),
                    const _TimerColon(),
                    _TimerBox(value: s),
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Get.toNamed('/home'),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'View All',
                  style: AppTextStyle.cardTitleStyle().copyWith(
                    color: AppColors.primary2,
                    fontSize: isMobile ? 14 : 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: listHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = widget.products[index];
                final id = product['id'].toString();
                return SizedBox(
                  width: cardWidth,
                  child: PremiumProductCard(
                    id: id,
                    name: (product['name'] ?? '').toString(),
                    image: (product['image'] ?? '').toString(),
                    price: ((product['price'] as num?) ?? 0).toDouble(),
                    originalPrice:
                        ((product['originalPrice'] as num?) ?? 0).toDouble(),
                    rating: ((product['rating'] as num?) ?? 0).toDouble(),
                    reviewCount:
                        ((product['reviewCount'] as num?) ?? 0).toInt(),
                    cardHeight: 400,
                    isWishlisted: product['isWishlisted'] == true,
                    isSponsored: product['isSponsored'] == true,
                    lowestPrice30Days:
                        (product['lowestPrice30Days'] as num?)?.toDouble(),
                    onTap: () => widget.onProductTap(id),
                    onAddToCart: () => CartController.ensureInitialized()
                        .addMapProductToCart(product),
                    onWishlistToggle: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TimerBox extends StatelessWidget {
  final String value;
  const _TimerBox({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4500),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _TimerColon extends StatelessWidget {
  const _TimerColon();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Text(
        ':',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

// --- Deal of the Day Section ----------------------------------
class _DealOfTheDaySection extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;
  const _DealOfTheDaySection({
    required this.product,
    required this.onTap,
  });

  @override
  State<_DealOfTheDaySection> createState() => _DealOfTheDaySectionState();
}

class _DealOfTheDaySectionState extends State<_DealOfTheDaySection> {
  late Timer _timer;
  Duration _remaining = const Duration(hours: 8, minutes: 30);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_remaining.inSeconds > 0) {
        setState(() => _remaining -= const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final h = _pad(_remaining.inHours);
    final m = _pad(_remaining.inMinutes.remainder(60));
    final s = _pad(_remaining.inSeconds.remainder(60));
    final name = (widget.product['name'] ?? 'Premium Product').toString();
    final price = ((widget.product['price'] as num?) ?? 0).toDouble();
    final originalPrice =
        ((widget.product['originalPrice'] as num?) ?? 0).toDouble();
    final discount = originalPrice > price && originalPrice > 0
        ? ((originalPrice - price) / originalPrice * 100).round()
        : 0;
    final rating = ((widget.product['rating'] as num?) ?? 0).toDouble();
    final reviewCount = ((widget.product['reviewCount'] as num?) ?? 0).toInt();
    final lowestPrice30Days =
        (widget.product['lowestPrice30Days'] as num?)?.toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1A1A2E).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.04),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFD700),
                                Color(0xFFFFA500),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '?? Deal of the Day',
                            style: TextStyle(
                              color: Color(0xFF1A1A2E),
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        if (widget.product['isSponsored'] == true) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.94),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Text(
                              'Sponsored',
                              style: TextStyle(
                                color: AppColors.black1,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                        const Spacer(),
                        const Icon(
                          Icons.timer_outlined,
                          color: Colors.white54,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$h:$m:$s',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            productCardImageForTesting,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.image,
                                color: Colors.white38,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 14,
                                    color: Color(0xFFFFD700),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    rating.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    ' ($reviewCount)',
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (discount > 0)
                                    Text(
                                      '$discount% OFF',
                                      style: const TextStyle(
                                        color: Color(0xFFFFB38A),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    '?${price.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      color: Color(0xFFFFD700),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  if (originalPrice > price) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      '?${originalPrice.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        color: Colors.white38,
                                        fontSize: 13,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              if (lowestPrice30Days != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  '30-day low ?${lowestPrice30Days.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 10),
                              ProductAddToCartButton(
                                compact: true,
                                onPressed: () =>
                                    CartController.ensureInitialized()
                                        .addMapProductToCart(widget.product),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selling fast!',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '73% sold',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.73,
                        backgroundColor: Colors.white.withOpacity(0.12),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFFFD700),
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Top Brands Section ---------------------------------------
class _BrandRowSection extends StatelessWidget {
  const _BrandRowSection();

  static const _brands = <Map<String, dynamic>>[
    {'name': 'Nike', 'initial': 'N', 'color': Color(0xFF111111)},
    {'name': 'Adidas', 'initial': 'A', 'color': Color(0xFF000000)},
    {'name': 'H&M', 'initial': 'H', 'color': Color(0xFFCC0000)},
    {'name': 'Zara', 'initial': 'Z', 'color': Color(0xFF1B1B1B)},
    {'name': 'Puma', 'initial': 'P', 'color': Color(0xFF00314C)},
    {'name': "Levi's", 'initial': 'L', 'color': Color(0xFFCC0000)},
    {'name': 'F21', 'initial': 'F', 'color': Color(0xFF242424)},
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      backgroundColor: const Color(0xFFF8F8F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'Top Brands',
            actionLabel: 'All Brands',
            onActionTap: () => Get.toNamed('/home'),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 82,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _brands.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final brand = _brands[index];
                final color = brand['color'] as Color;
                final name = brand['name'] as String;
                final initial = brand['initial'] as String;
                return GestureDetector(
                  onTap: () => Get.toNamed('/home'),
                  child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFEEEEEE),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              initial,
                              style: TextStyle(
                                color: color,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _BenefitTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18, color: AppColors.primary1),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color(0xFF767676),
            ),
          ),
        ],
      ),
    );
  }
}
