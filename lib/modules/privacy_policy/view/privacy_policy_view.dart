import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/premium_app_bar.dart';
import '../../../shared/utils/responsive_util.dart';
import '../controller/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Privacy Policy',
        showBackButton: true,
      ),
      body: const ResponsiveContent(
        addHorizontalPadding: true,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(text: 'Cancellation Policy'),
                SizedBox(height: 14),
                _PolicyParagraph(
                  text:
                      'At our marketplace, cancellations are handled with flexibility while ensuring fair usage for buyers and sellers. Orders can be cancelled before dispatch from the order details section. Once an order is packed or handed over to the logistics partner, cancellation may no longer be available.',
                ),
                SizedBox(height: 16),
                _PolicyParagraph(
                  text:
                      'If payment has already been completed, eligible refunds are initiated to the original payment method after cancellation confirmation. Refund timelines may vary depending on your bank or payment provider, but we continuously monitor all requests to ensure timely processing.',
                ),
                SizedBox(height: 16),
                _PolicyParagraph(
                  text:
                      'Repeated cancellation behavior that affects operational quality may lead to temporary restrictions on promotional offers or cash-on-delivery options. This is done only to maintain platform reliability and improve the customer experience for all users.',
                ),
                SizedBox(height: 30),
                _SectionTitle(text: 'Terms & Condition'),
                SizedBox(height: 14),
                _PolicyParagraph(
                  text:
                      'By using this application, you agree to comply with all applicable terms governing orders, payments, returns, communication, and account usage. You are responsible for maintaining accurate account information and protecting your login credentials at all times.',
                ),
                SizedBox(height: 16),
                _PolicyParagraph(
                  text:
                      'Product availability, pricing, delivery timelines, and promotional benefits may change without prior notice based on inventory, location, and merchant policies. While we aim for accuracy, unintentional listing errors may occur and can be corrected as required under platform policy.',
                ),
                SizedBox(height: 16),
                _PolicyParagraph(
                  text:
                      'Any misuse of coupons, referral benefits, wallet credits, or fraudulent activity may result in order cancellation, account review, or suspension. We reserve the right to update these terms from time to time, and continued platform usage after updates will be treated as acceptance of revised conditions.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.primary1,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _PolicyParagraph extends StatelessWidget {
  const _PolicyParagraph({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        color: AppColors.muteIconColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 24 / 14,
      ),
    );
  }
}
