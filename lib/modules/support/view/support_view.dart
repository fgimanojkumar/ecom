import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/utils/responsive_util.dart';
import 'package:imoss/shared/widgets/premium_app_bar.dart';

import '../controller/support_controller.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView>
    with SingleTickerProviderStateMixin {
  final SupportController controller = Get.find<SupportController>();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      controller.setSelectedTab(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Help Center',
        showBackButton: true,
      ),
      body: SafeArea(
        child: ResponsiveContent(
          addHorizontalPadding: true,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.white1,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TextField(
                    onChanged: controller.updateSearch,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: AppColors.muteIconColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: AppColors.muteIconColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TabBar(
                controller: _tabController,
                indicator: const _RoundedTabIndicator(
                  color: AppColors.primary1,
                  width: 32,
                  thickness: 3,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: AppColors.primary1,
                unselectedLabelColor: AppColors.muteIconColor,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: 'FAQ'),
                  Tab(text: 'Contact Us'),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildFaqList(),
                    _buildContactAccordion(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: controller.faqItems.length,
      itemBuilder: (context, index) {
        final item = controller.faqItems[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.white2),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 14),
            title: Text(
              item['question'] as String,
              style: const TextStyle(
                color: AppColors.black1,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            children: [
              Text(
                item['answer'] as String,
                style: const TextStyle(
                  color: AppColors.muteIconColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactAccordion() {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemCount: controller.contactItems.length,
        itemBuilder: (context, index) {
          final item = controller.contactItems[index];
          final expanded = controller.expandedContactIndex.value == index;

          return _ContactAccordionCard(
            title: item['title'] ?? '',
            icon: item['icon'] ?? '',
            detail: item['detail'] ?? '',
            expanded: expanded,
            onTap: () => controller.toggleContact(index),
          );
        },
      ),
    );
  }
}

class _ContactAccordionCard extends StatelessWidget {
  const _ContactAccordionCard({
    required this.title,
    required this.icon,
    required this.detail,
    required this.expanded,
    required this.onTap,
  });

  final String title;
  final String icon;
  final String detail;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          child: Column(
            children: [
              Row(
                children: [
                  _iconWidget(icon),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.black1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 280),
                    turns: expanded ? 0.5 : 0,
                    curve: Curves.easeOut,
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                      color: AppColors.muteIconColor,
                    ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: expanded && detail.isNotEmpty
                    ? Column(
                        children: [
                          const SizedBox(height: 12),
                          const Divider(height: 1, color: AppColors.white2),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const SizedBox(width: 40),
                              Text(
                                '• $detail',
                                style: const TextStyle(
                                  color: AppColors.black1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconWidget(String iconType) {
    switch (iconType) {
      case 'headset':
        return const Icon(Icons.headset_mic_rounded, color: AppColors.black1);
      case 'whatsapp':
        return const Icon(Icons.chat_bubble_rounded,
            color: AppColors.statusBtnGreen);
      case 'website':
        return const Icon(Icons.language_rounded, color: AppColors.black1);
      case 'facebook':
        return const Icon(Icons.facebook_rounded, color: AppColors.buttonColor);
      case 'x':
        return const Text(
          'X',
          style: TextStyle(
            color: AppColors.black1,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        );
      case 'instagram':
        return const Icon(Icons.camera_alt_rounded, color: AppColors.primary1);
      default:
        return const Icon(Icons.support_agent_rounded, color: AppColors.black1);
    }
  }
}

class _RoundedTabIndicator extends Decoration {
  const _RoundedTabIndicator({
    required this.color,
    required this.width,
    required this.thickness,
  });

  final Color color;
  final double width;
  final double thickness;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _RoundedTabIndicatorPainter(
      color: color,
      width: width,
      thickness: thickness,
    );
  }
}

class _RoundedTabIndicatorPainter extends BoxPainter {
  _RoundedTabIndicatorPainter({
    required this.color,
    required this.width,
    required this.thickness,
  });

  final Color color;
  final double width;
  final double thickness;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = Offset(
          offset.dx + (configuration.size!.width - width) / 2,
          offset.dy + configuration.size!.height - thickness,
        ) &
        Size(width, thickness);

    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(thickness));
    final paint = Paint()..color = color;
    canvas.drawRRect(rRect, paint);
  }
}
