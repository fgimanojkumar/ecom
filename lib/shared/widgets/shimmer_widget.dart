import 'package:flutter/material.dart';

/// Animated shimmer placeholder — no external package needed.
class ShimmerWidget extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
    _anim = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          gradient: LinearGradient(
            begin: Alignment(_anim.value - 1, 0),
            end: Alignment(_anim.value + 1, 0),
            colors: const [
              Color(0xFFEAEAEA),
              Color(0xFFF5F5F5),
              Color(0xFFEAEAEA),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ready-to-use shimmer placeholder shaped like a product card.
class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerWidget(
            width: double.infinity,
            height: 130,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget(
                    width: double.infinity,
                    height: 13,
                    borderRadius: BorderRadius.circular(4)),
                const SizedBox(height: 6),
                ShimmerWidget(
                    width: 90,
                    height: 13,
                    borderRadius: BorderRadius.circular(4)),
                const SizedBox(height: 8),
                ShimmerWidget(
                    width: 60,
                    height: 16,
                    borderRadius: BorderRadius.circular(4)),
                const SizedBox(height: 8),
                ShimmerWidget(
                    width: double.infinity,
                    height: 32,
                    borderRadius: BorderRadius.circular(10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer placeholder for a list-style product row.
class ShimmerListCard extends StatelessWidget {
  const ShimmerListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ShimmerWidget(
            width: 110,
            height: 100,
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(18)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                      width: double.infinity,
                      height: 13,
                      borderRadius: BorderRadius.circular(4)),
                  const SizedBox(height: 6),
                  ShimmerWidget(
                      width: 100,
                      height: 13,
                      borderRadius: BorderRadius.circular(4)),
                  const SizedBox(height: 10),
                  ShimmerWidget(
                      width: 70,
                      height: 18,
                      borderRadius: BorderRadius.circular(4)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
