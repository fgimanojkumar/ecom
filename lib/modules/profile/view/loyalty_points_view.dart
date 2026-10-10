import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/demo/demo_account_store.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';

class LoyaltyPointsView extends StatelessWidget {
  const LoyaltyPointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Reward points',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary1, AppColors.gradientEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.workspace_premium_outlined,
                              color: AppColors.white, size: 22),
                          SizedBox(width: 9),
                          Text(
                            'Available balance',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Obx(
                        () => Text(
                          '${DemoAccountStore.loyaltyPoints} points',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Points earned from eligible rewards',
                        style: TextStyle(
                          color: Color(0xE6FFFFFF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                const Text(
                  'Ways to earn',
                  style: TextStyle(
                    color: AppColors.black1,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.white2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary1.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.card_giftcard_outlined,
                            color: AppColors.primary1),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Refer a friend',
                              style: TextStyle(
                                color: AppColors.black1,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Earn 150 points after a new friend completes their first order.',
                              style: TextStyle(
                                color: AppColors.black2,
                                fontSize: 12,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed('/referAndEarn'),
                        child: const Text('Invite'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                const Text(
                  'Recent activity',
                  style: TextStyle(
                    color: AppColors.black1,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Reward transactions will appear here when points are credited.',
                  style: TextStyle(
                    color: AppColors.black2,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 18),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded,
                        color: AppColors.info, size: 18),
                    SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        'This demo shows the account balance only. Referral crediting and point redemption are not connected yet.',
                        style: TextStyle(
                          color: AppColors.black2,
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
