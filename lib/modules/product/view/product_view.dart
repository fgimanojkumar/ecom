import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../../../shared/widgets/premium_product_card.dart';

class ProductListingView extends StatefulWidget {
  const ProductListingView({super.key});

  @override
  State<ProductListingView> createState() => _ProductListingViewState();
}

class _ProductListingViewState extends State<ProductListingView> {
  bool isGrid = true;
  String _sortLabel = 'Popular';
  int _displayedCount = 20;
  bool _isLoadingMore = false;
  int _activeFilterCount = 0;
  static const int _pageSize = 20;
  static const int _totalProducts = 100;

  int get _currentPage => (_displayedCount / _pageSize).ceil();
  int get _totalPages => (_totalProducts / _pageSize).ceil();

  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> categories = [
    'All',
    'Electronics',
    'Fashion',
    'Beauty',
    'Sports',
    'Home',
    'Accessories',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 300 &&
        !_isLoadingMore &&
        _displayedCount < _totalProducts) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() {
      _displayedCount = (_displayedCount + _pageSize).clamp(0, _totalProducts);
      _isLoadingMore = false;
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _displayedCount = _pageSize;
      _isLoadingMore = false;
    });
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final responsiveGridCount = width >= 1180
        ? 4
        : width >= 860
            ? 3
            : 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PremiumAppBar(
        title: 'Products',
        showBackButton: true,
        actions: [
          GestureDetector(
            onTap: () => setState(() => isGrid = !isGrid),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
                color: AppColors.primary1,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ─── FILTER + COUNT BAR ──────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '245 Products Found',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showFilterSheet(context),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D3A45),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.tune_rounded,
                                color: Colors.white, size: 15),
                            SizedBox(width: 5),
                            Text(
                              'Filter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_activeFilterCount > 0)
                        Positioned(
                          top: -5,
                          right: -5,
                          child: Container(
                            width: 17,
                            height: 17,
                            decoration: const BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$_activeFilterCount',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _showSortSheet(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFDDDDDD)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sort_rounded,
                            color: Colors.grey[700], size: 15),
                        const SizedBox(width: 5),
                        Text(
                          _sortLabel,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Page indicator ───────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Row(
              children: [
                Text(
                  'Page $_currentPage of $_totalPages',
                  style: TextStyle(
                    color: AppColors.black2,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_totalPages, (i) {
                        final page = i + 1;
                        final isLoaded = page <= _currentPage;
                        final isCurrent = page == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 6),
                          width: isCurrent ? 28 : 22,
                          height: isCurrent ? 28 : 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCurrent
                                ? AppColors.primary1
                                : isLoaded
                                    ? AppColors.gradientEnd.withOpacity(0.35)
                                    : AppColors.white2,
                            boxShadow: isCurrent
                                ? [
                                    BoxShadow(
                                      color:
                                          AppColors.primary1.withOpacity(0.35),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              '$page',
                              style: TextStyle(
                                fontSize: isCurrent ? 11 : 10,
                                fontWeight: FontWeight.w700,
                                color: isCurrent
                                    ? AppColors.white
                                    : isLoaded
                                        ? AppColors.primary1
                                        : AppColors.muteIconColor,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ─── PRODUCTS GRID ───────────────────────────────
          Expanded(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              color: AppColors.primary1,
              child: GridView.builder(
                controller: _scrollController,
                primary: false,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                // +1 for the bottom loader tile
                itemCount: _displayedCount +
                    (_displayedCount < _totalProducts ? 1 : 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isGrid ? responsiveGridCount : 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: isGrid
                      ? (width >= 980 ? 0.78 : 0.62)
                      : (width >= 980 ? 3.0 : 2.4),
                ),
                itemBuilder: (context, index) {
                  // Bottom loader spans full row
                  if (index == _displayedCount) {
                    // Loader tile: use SizedBox to span a single cell cleanly
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _isLoadingMore
                            ? CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.primary1,
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Page $_currentPage loaded · ${_totalProducts - _displayedCount} more',
                                    style: TextStyle(
                                        fontSize: 12, color: AppColors.black2),
                                  ),
                                  const SizedBox(height: 6),
                                  TextButton(
                                    onPressed: _loadMore,
                                    child: Text(
                                      'Load Page ${_currentPage + 1}',
                                      style:
                                          TextStyle(color: AppColors.primary1),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  }
                  return _ProductCard(isGrid: isGrid, index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FilterSheet(
        onApply: (count) => setState(() => _activeFilterCount = count),
        onReset: () => setState(() => _activeFilterCount = 0),
      ),
    );
  }

  void _showSortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _SortSheet(
        selected: _sortLabel,
        onSelect: (val) => setState(() => _sortLabel = val),
      ),
    );
  }
}

// ─── Product Card (grid + list) ───────────────────────────────
class _ProductCard extends StatelessWidget {
  final bool isGrid;
  final int index;
  const _ProductCard({required this.isGrid, required this.index});

  @override
  Widget build(BuildContext context) {
    return isGrid ? _GridCard(index: index) : _ListCard(index: index);
  }
}

class _GridCard extends StatelessWidget {
  final int index;
  const _GridCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return PremiumProductCard(
      id: 'p$index',
      name: 'Premium Smart Watch Ultra Pro ${index + 1}',
      image: 'https://picsum.photos/300?random=$index',
      price: 4999,
      originalPrice: 7999,
      rating: 4.8,
      reviewCount: 120,
      isWishlisted: false,
      onTap: () {},
      onWishlistToggle: () {},
    );
  }
}

class _ListCard extends StatelessWidget {
  final int index;
  const _ListCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(18),
                ),
                child: Image.network(
                  'https://picsum.photos/300?random=$index',
                  width: 110,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 110,
                    color: const Color(0xFFF0F0F0),
                    child: const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF4500), Color(0xFFFF6B35)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '30% OFF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Premium Smart Watch Ultra Pro Series',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFF222222),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFFC107), size: 14),
                      const SizedBox(width: 3),
                      const Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF555555),
                        ),
                      ),
                      Text(
                        ' (120)',
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '₹4,999',
                            style: TextStyle(
                              color: Color(0xFF0F6B43),
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '₹7,999',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.favorite_border_rounded,
                color: Colors.grey[400], size: 20),
          ),
        ],
      ),
    );
  }
}

// ─── Filter Bottom Sheet ──────────────────────────────────────
class _FilterSheet extends StatefulWidget {
  final ValueChanged<int>? onApply;
  final VoidCallback? onReset;

  const _FilterSheet({this.onApply, this.onReset});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  int _tab = 0;
  final List<bool> _checked = [true, false, false, false, false];
  RangeValues _price = const RangeValues(500, 10000);

  static const _tabs = ['Category', 'Brand', 'Price', 'Rating'];
  static const _items = ['Electronics', 'Fashion', 'Shoes', 'Beauty', 'Sports'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Row(
              children: [
                const Text(
                  'Filter Products',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF222222),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _checked.fillRange(0, _checked.length, false);
                      _price = const RangeValues(500, 10000);
                    });
                    widget.onReset?.call();
                    Navigator.pop(context);
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 110,
                  color: const Color(0xFFF8F8F8),
                  child: ListView.builder(
                    itemCount: _tabs.length,
                    itemBuilder: (context, i) {
                      final sel = _tab == i;
                      return GestureDetector(
                        onTap: () => setState(() => _tab = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: sel ? Colors.white : Colors.transparent,
                            border: sel
                                ? const Border(
                                    left: BorderSide(
                                      color: Color(0xFF0F6B43),
                                      width: 3,
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            _tabs[i],
                            style: TextStyle(
                              fontWeight:
                                  sel ? FontWeight.w700 : FontWeight.w400,
                              color: sel
                                  ? const Color(0xFF0F6B43)
                                  : Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _tab == 2
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹${_price.start.round()} — ₹${_price.end.round()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 16),
                              RangeSlider(
                                values: _price,
                                min: 0,
                                max: 50000,
                                activeColor: const Color(0xFF0F6B43),
                                onChanged: (v) => setState(() => _price = v),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: _items.length,
                            itemBuilder: (context, i) => CheckboxListTile(
                              value: i < _checked.length ? _checked[i] : false,
                              onChanged: (v) {
                                if (i < _checked.length) {
                                  setState(() => _checked[i] = v ?? false);
                                }
                              },
                              title: Text(_items[i]),
                              activeColor: const Color(0xFF0F6B43),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final count = _checked.where((c) => c).length +
                      (_price != const RangeValues(500, 10000) ? 1 : 0);
                  widget.onApply?.call(count);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F6B43),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sort Bottom Sheet ────────────────────────────────────────
class _SortSheet extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  const _SortSheet({required this.selected, required this.onSelect});

  static const _labels = [
    'Popular',
    'Price: Low → High',
    'Price: High → Low',
    'Rating',
    'Newest',
  ];
  static const _icons = [
    Icons.trending_up_rounded,
    Icons.arrow_upward_rounded,
    Icons.arrow_downward_rounded,
    Icons.star_rounded,
    Icons.fiber_new_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 4, 16, 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          ...List.generate(_labels.length, (i) {
            final isSel = selected == _labels[i];
            return ListTile(
              onTap: () {
                onSelect(_labels[i]);
                Navigator.pop(context);
              },
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSel
                      ? const Color(0xFF0F6B43).withOpacity(0.1)
                      : const Color(0xFFF5F5F5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _icons[i],
                  size: 18,
                  color: isSel ? const Color(0xFF0F6B43) : Colors.grey[600],
                ),
              ),
              title: Text(
                _labels[i],
                style: TextStyle(
                  fontWeight: isSel ? FontWeight.w700 : FontWeight.w400,
                  color:
                      isSel ? const Color(0xFF0F6B43) : const Color(0xFF333333),
                ),
              ),
              trailing: isSel
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF0F6B43),
                      size: 20,
                    )
                  : null,
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

Widget productListingView(RxBool isGrid) {
  return Expanded(
    child: Obx(
      () => GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isGrid.value ? 2 : 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: isGrid.value ? 0.68 : 2.8,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                18,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(
                    .05,
                  ),
                  blurRadius: 8,
                )
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                            18,
                          ),
                          topRight: Radius.circular(
                            18,
                          ),
                        ),
                        child: Image.network(
                          'https://www.equinetmedia.com/hubfs/How-to-find-b2b-blog-images.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: const Text(
                            '30% OFF',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              size: 18,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Premium Smart Watch',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.statusBtnYellow,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            '4.8',
                          ),
                          Text(
                            ' (120)',
                            style: TextStyle(
                              color: AppColors.black2,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        '₹4,999',
                        style: TextStyle(
                          color: AppColors.primary2,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget filter(context, RxBool isGrid) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          blurRadius: 8,
          color: AppColors.black.withOpacity(.04),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              _showFilterSheet(context);
            },
            icon: const Icon(Icons.tune),
            label: const Text('Filter'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary2,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              _showFilterSheet(context);
            },
            icon: const Icon(Icons.sort),
            label: const Text('Sort'),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white1,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              isGrid.value ? Icons.view_list_rounded : Icons.grid_view_rounded,
            ),
          ),
        ),
      ],
    ),
  );
}

void _showFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .75,
        child: Row(
          children: [
            Container(
              width: 120,
              color: AppColors.white1,
              child: ListView(
                children: const [
                  ListTile(
                    tileColor: AppColors.primary2,
                    textColor: AppColors.white,
                    title: Text('Category'),
                  ),
                  ListTile(
                    title: Text('Brand'),
                  ),
                  ListTile(
                    title: Text('Price'),
                  ),
                  ListTile(
                    title: Text('Rating'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: true,
                      onChanged: (_) {},
                      title: const Text('Electronics'),
                    ),
                    CheckboxListTile(
                      value: false,
                      onChanged: (_) {},
                      title: const Text('Fashion'),
                    ),
                    CheckboxListTile(
                      value: false,
                      onChanged: (_) {},
                      title: const Text('Shoes'),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary2,
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
