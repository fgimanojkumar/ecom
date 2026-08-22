import 'package:flutter/material.dart';
import 'package:imoss/shared/style/app_colors.dart';

class PremiumCategoryCard extends StatefulWidget {
  final String name;
  final String image;
  final String icon;
  final VoidCallback onTap;
  final bool showOverlay;

  const PremiumCategoryCard({
    super.key,
    required this.name,
    required this.image,
    required this.icon,
    required this.onTap,
    this.showOverlay = true,
  });

  @override
  State<PremiumCategoryCard> createState() => _PremiumCategoryCardState();
}

class _PremiumCategoryCardState extends State<PremiumCategoryCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animationController = _controller;

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => animationController?.forward(),
        onExit: (_) => animationController?.reverse(),
        child: AnimatedBuilder(
          animation: animationController ?? kAlwaysDismissedAnimation,
          builder: (context, child) {
            final animationValue = animationController?.value ?? 0;
            return Transform.scale(
              scale: 1 + (animationValue * 0.03),
              child: widget.showOverlay
                  ? Card(
                      margin: EdgeInsets.zero,
                      elevation: 3 + (animationValue * 5),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              widget.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.white2,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 40,
                                      color: AppColors.greyLight,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.black.withOpacity(0.15),
                                    AppColors.black.withOpacity(0.75),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      widget.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Explore',
                                    style: TextStyle(
                                      color: AppColors.white.withOpacity(0.7),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFEFEFEF)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.network(
                                      widget.image,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: AppColors.white2,
                                          child: const Center(
                                            child: Icon(
                                              Icons.image,
                                              size: 30,
                                              color: AppColors.greyLight,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        child: Icon(
                                          Icons.category,
                                          size: 16,
                                          color: const Color(0xFF0F6B43),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                widget.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Explore',
                              style: TextStyle(
                                color: Color(0xFF888888),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
