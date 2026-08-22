import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/utils/responsive_util.dart';

class SpecialOffersView extends StatelessWidget {
  const SpecialOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color white = AppColors.white;
    const Color primaryDark = AppColors.primary1;
    const Color primaryText = AppColors.black1;
    const Color secondaryText = AppColors.black2;
    const Color accentPink = AppColors.statusBtnYellow;

    final List<Map<String, String>> offers = [
      {
        'discount': '25%',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
        'time': '08:44:32',
      },
      {
        'discount': '30%',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
        'time': '05:22:15',
      },
      {
        'discount': '20%',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
        'time': '12:15:45',
      },
      {
        'discount': '10%',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
        'time': '03:30:20',
      },
      {
        'discount': '15%',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
        'time': '07:10:00',
      },
    ];

    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: SafeArea(
          child: ResponsiveContent(
            addHorizontalPadding: true,
            child: Column(
              children: [
                // Custom App Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.arrow_back,
                              color: primaryDark, size: 20),
                        ),
                      ),
                      // Title
                      const Text(
                        'Special Offers',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryText,
                        ),
                      ),
                      // Menu Button
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.more_vert,
                              color: primaryDark, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                // Scrollable Offer Cards
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      final offer = offers[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Product Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      offer['image']!,
                                      width: 120,
                                      height: 140,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          width: 120,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            color: AppColors.white1,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: const Icon(
                                            Icons.image,
                                            color: secondaryText,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Content Section
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Discount Percentage
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: offer['discount'],
                                                style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w800,
                                                  color: primaryDark,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: ' OFF',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: secondaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Subtitle
                                        const Text(
                                          'Discount valid today only',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: secondaryText,
                                            height: 1.4,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        // Order Now Button
                                        SizedBox(
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryDark,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24),
                                            ),
                                            child: const Text(
                                              'Order Now',
                                              style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                letterSpacing: -0.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Countdown Timer Badge
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: accentPink.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: accentPink.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: accentPink,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      offer['time']!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
