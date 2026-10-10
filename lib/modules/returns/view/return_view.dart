import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/returns_controller.dart';

class ReturnView extends StatefulWidget {
  const ReturnView({super.key});

  @override
  State<ReturnView> createState() => _ReturnViewState();
}

class _ReturnViewState extends State<ReturnView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    Get.find<ReturnsController>().selectOrder(Get.arguments);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.25, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final returnsController = Get.find<ReturnsController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Return & Refund Status',
        showBackButton: true,
      ),
      body: Obx(() {
        final order = returnsController.selectedOrder.value;
        final currentStep = returnsController.currentStep.value;
        return ResponsiveContent(
          addHorizontalPadding: true,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: order == null || currentStep < 0
                  ? _emptyState(ReturnsController.steps)
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.white1,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.white2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primary1.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.assignment_return_outlined,
                                  color: AppColors.primary1,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order ${order['id']}',
                                      style: const TextStyle(
                                        color: AppColors.black1,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${order['items'] ?? 1} items · Return in progress',
                                      style: const TextStyle(
                                        color: AppColors.black2,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.verified_outlined,
                                  color: AppColors.success),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Return progress',
                          style: TextStyle(
                            color: AppColors.black1,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 18),
                        ...List.generate(ReturnsController.steps.length,
                            (index) {
                          final isComplete = index < currentStep;
                          final isCurrent = index == currentStep;
                          final color = isComplete || isCurrent
                              ? AppColors.primary1
                              : AppColors.white2;
                          return IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  width: 26,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          color: isComplete
                                              ? AppColors.primary1
                                              : AppColors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: color,
                                            width: 2,
                                          ),
                                        ),
                                        child: isComplete
                                            ? const Icon(Icons.check_rounded,
                                                size: 14,
                                                color: AppColors.white)
                                            : isCurrent
                                                ? AnimatedBuilder(
                                                    animation: _pulse,
                                                    builder: (context, child) {
                                                      final dotSize = 7 +
                                                          (_pulse.value * 3);
                                                      return Center(
                                                        child: Container(
                                                          width: dotSize,
                                                          height: dotSize,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .primary1
                                                                .withValues(
                                                              alpha:
                                                                  _pulse.value,
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : null,
                                      ),
                                      if (index <
                                          ReturnsController.steps.length - 1)
                                        Expanded(
                                          child: Container(
                                            width: 2,
                                            color: index < currentStep
                                                ? AppColors.primary1
                                                : AppColors.white2,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 22),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ReturnsController.steps[index],
                                          style: TextStyle(
                                            color: isCurrent || isComplete
                                                ? AppColors.black1
                                                : AppColors.black2,
                                            fontSize: 14,
                                            fontWeight: isCurrent
                                                ? FontWeight.w800
                                                : FontWeight.w600,
                                          ),
                                        ),
                                        if (isCurrent) ...[
                                          const SizedBox(height: 5),
                                          Text(
                                            returnsController
                                                .currentDescription(
                                              index,
                                            ),
                                            style: const TextStyle(
                                              color: AppColors.black2,
                                              fontSize: 12,
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.info.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline_rounded,
                                  color: AppColors.info, size: 18),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Refunds are credited to the original payment method after the returned item is received and checked.',
                                  style: TextStyle(
                                    color: AppColors.black2,
                                    fontSize: 12,
                                    height: 1.45,
                                  ),
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
      }),
    );
  }

  Widget _emptyState(List<String> steps) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        const Icon(Icons.receipt_long_outlined,
            size: 42, color: AppColors.muteIconColor),
        const SizedBox(height: 12),
        const Text(
          'No return in progress',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black1,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Choose a delivered order to request a return. Your progress will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.black2, height: 1.45),
        ),
        const SizedBox(height: 24),
        const Text(
          'Return and refund steps',
          style: TextStyle(
            color: AppColors.black1,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(steps.length, (index) {
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 26,
                  child: Column(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white2, width: 2),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: AppColors.muteIconColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (index < steps.length - 1)
                        Expanded(
                          child: Container(width: 2, color: AppColors.white2),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 18),
                    child: Text(
                      steps[index],
                      style: const TextStyle(
                        color: AppColors.black2,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.center,
          child: OutlinedButton.icon(
            onPressed: () => Get.toNamed('/myOrders'),
            icon: const Icon(Icons.receipt_long_outlined),
            label: const Text('View orders'),
          ),
        ),
      ],
    );
  }
}
