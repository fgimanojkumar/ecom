import 'package:imoss/shared/style/app_colors.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/widgets/app_toast.dart';
import 'package:imoss/shared/widgets/premium_app_bar.dart';
import 'package:imoss/shared/utils/responsive_util.dart';

import '../controller/coupon_controller.dart';

class CouponView extends GetView<CouponController> {
  const CouponView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Coupons',
        showBackButton: true,
      ),
      body: SafeArea(
        child: ResponsiveContent(
          addHorizontalPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Best offers for you',
                  style: TextStyle(
                    color: AppColors.black1,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Applied coupon banner
              Obx(() {
                final applied = controller.appliedCouponCode.value;
                if (applied.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primary1.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.primary1.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_rounded,
                            color: AppColors.primary1, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 13, color: AppColors.black1),
                              children: [
                                const TextSpan(text: 'Applied: '),
                                TextSpan(
                                  text: applied,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary1,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.removeCoupon,
                          child: const Text(
                            'Remove',
                            style: TextStyle(
                              color: AppColors.error,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Expanded(
                child: Obx(
                  () => ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                    itemCount: controller.coupons.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final coupon = controller.coupons[index];
                      final code = coupon['code'] as String? ?? '';
                      final expired = controller.isExpired(coupon);
                      final isApplied =
                          controller.appliedCouponCode.value == code;
                      return _CouponCard(
                        discountText: coupon['discount'] ?? '',
                        code: code,
                        description: coupon['description'] ?? '',
                        unlockMessage: coupon['unlock'] ?? '',
                        expiryLabel: controller.expiryLabel(coupon),
                        termsText: coupon['terms'] ?? '',
                        stripGradient: expired
                            ? [Colors.grey.shade400, Colors.grey.shade300]
                            : List<Color>.from(
                                (coupon['gradientColors'] as List?) ??
                                    [AppColors.primary1, AppColors.gradientEnd],
                              ),
                        isExpired: expired,
                        isApplied: isApplied,
                        isEven: index.isEven,
                        onTapTerms: () => _showTermsDialog(
                          context,
                          code,
                          controller.getTerms(code),
                        ),
                        onCopyCode: expired
                            ? null
                            : () {
                                Clipboard.setData(ClipboardData(text: code));
                                AppToast.successToast('Code "$code" copied!');
                              },
                        onApply: expired
                            ? null
                            : isApplied
                                ? controller.removeCoupon
                                : () => controller.applyCoupon(code),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTermsDialog(BuildContext context, String code, String terms) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TermsSheet(code: code, terms: terms),
    );
  }
}

class _TermsSheet extends StatelessWidget {
  final String code;
  final String terms;
  const _TermsSheet({required this.code, required this.terms});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 6),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.gavel_rounded,
                    color: AppColors.primary1,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black1,
                        ),
                      ),
                      Text(
                        'Coupon: $code',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primary1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close,
                        size: 18, color: AppColors.black2),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: Divider(height: 1),
          ),
          // Terms content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Text(
                terms,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.black2,
                  height: 1.9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CouponCard extends StatelessWidget {
  const _CouponCard({
    required this.discountText,
    required this.code,
    required this.description,
    required this.unlockMessage,
    required this.expiryLabel,
    required this.termsText,
    required this.stripGradient,
    required this.isExpired,
    required this.isApplied,
    required this.isEven,
    required this.onTapTerms,
    this.onCopyCode,
    this.onApply,
  });

  final String discountText;
  final String code;
  final String description;
  final String unlockMessage;
  final String expiryLabel;
  final String termsText;
  final List<Color> stripGradient;
  final bool isExpired;
  final bool isApplied;
  final bool isEven;
  final VoidCallback onTapTerms;
  final VoidCallback? onCopyCode;
  final VoidCallback? onApply;

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = isExpired
        ? [Colors.grey.shade400, Colors.grey.shade300]
        : stripGradient;
    final borderColor = isApplied
        ? AppColors.primary1
        : isExpired
            ? Colors.grey.shade300
            : effectiveGradient.first.withOpacity(0.4);

    // Strip position: even = left, odd = right
    final stripLeft = isEven;
    final stripBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(stripLeft ? 16 : 0),
      bottomLeft: Radius.circular(stripLeft ? 16 : 0),
      topRight: Radius.circular(stripLeft ? 0 : 16),
      bottomRight: Radius.circular(stripLeft ? 0 : 16),
    );
    final contentPadding = stripLeft
        ? const EdgeInsets.fromLTRB(90, 12, 12, 12)
        : const EdgeInsets.fromLTRB(12, 12, 90, 12);
    return Opacity(
      opacity: isExpired ? 0.65 : 1.0,
      child: CustomPaint(
        painter: _DottedBorderPainter(
          color: borderColor,
          borderRadius: 16,
          strokeWidth: isApplied ? 1.8 : 1.2,
          dashLength: 6,
          dashGap: 4,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: effectiveGradient.first.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Strip (left for even, right for odd)
              Positioned(
                top: 0,
                bottom: 0,
                left: stripLeft ? 0 : null,
                right: stripLeft ? null : 0,
                child: ClipRRect(
                  borderRadius: stripBorderRadius,
                  child: Container(
                    width: 76,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: effectiveGradient,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Transform.rotate(
                      angle: stripLeft ? -math.pi / 2 : math.pi / 2,
                      child: Text(
                        isExpired ? 'EXPIRED' : discountText,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Ticket cutouts
              Positioned(
                  left: stripLeft ? -10 : null,
                  right: stripLeft ? null : -10,
                  top: 36,
                  child: _ticketCutout()),
              Positioned(
                  left: stripLeft ? -10 : null,
                  right: stripLeft ? null : -10,
                  bottom: 36,
                  child: _ticketCutout()),
              // Content
              Padding(
                padding: contentPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            description,
                            style: const TextStyle(
                              color: AppColors.black1,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (isApplied)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primary1.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '✓ Applied',
                              style: TextStyle(
                                color: AppColors.primary1,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Code chip + copy
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isExpired
                                  ? Colors.grey.shade100
                                  : AppColors.primary1.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isExpired
                                    ? Colors.grey.shade300
                                    : AppColors.primary1.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              code,
                              style: TextStyle(
                                color: isExpired
                                    ? Colors.grey.shade500
                                    : AppColors.primary1,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                decoration: isExpired
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        if (onCopyCode != null) ...[
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: onCopyCode,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.primary1,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Icon(Icons.copy_rounded,
                                  color: AppColors.white, size: 14),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: AppColors.white2),
                    const SizedBox(height: 8),
                    Text(
                      unlockMessage,
                      style: const TextStyle(
                          color: AppColors.black2,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        // Expiry label
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: isExpired
                                ? AppColors.error.withOpacity(0.1)
                                : AppColors.warning.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            expiryLabel,
                            style: TextStyle(
                              color: isExpired
                                  ? AppColors.error
                                  : AppColors.warning,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onTapTerms,
                          child: Text(
                            termsText,
                            style: const TextStyle(
                              color: AppColors.buttonColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Apply / Remove button
                        if (onApply != null)
                          GestureDetector(
                            onTap: onApply,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                gradient: isApplied
                                    ? null
                                    : const LinearGradient(colors: [
                                        AppColors.gradientStart,
                                        AppColors.gradientEnd,
                                      ]),
                                color: isApplied
                                    ? AppColors.error.withOpacity(0.1)
                                    : null,
                                borderRadius: BorderRadius.circular(20),
                                border: isApplied
                                    ? Border.all(
                                        color: AppColors.error.withOpacity(0.4))
                                    : null,
                              ),
                              child: Text(
                                isApplied ? 'Remove' : 'Apply',
                                style: TextStyle(
                                  color: isApplied
                                      ? AppColors.error
                                      : AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                      ],
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

  Widget _ticketCutout() {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: AppColors.white1,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  const _DottedBorderPainter({
    required this.color,
    required this.borderRadius,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final path = Path()..addRRect(rrect);

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dashLength).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dashLength + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(_DottedBorderPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.dashLength != dashLength;
}
