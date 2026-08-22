import 'package:flutter/material.dart';

import 'image_file.dart';
import 'image_file_view/io_preview.dart';
import 'multi_image_picker_controller.dart';

/// Widget that holds entire functionality of the [MultiImagePickerView].
class MultiImagePickerView extends StatefulWidget {
  final MultiImagePickerController controller;

  const MultiImagePickerView({
    super.key,
    required this.controller,
    this.draggable = true,
    this.shrinkWrap = false,
    this.gridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 160,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1,
    ),
    this.padding,
    this.initialWidget = const SizedBox(),
    this.addMoreButton = const SizedBox(),
    this.viewAllImagesButton = const SizedBox(),
    this.longPressDelayMilliseconds = 300,
    this.builder,
    this.onDragBoxDecoration,
  });

  final bool draggable;
  final bool shrinkWrap;
  final int longPressDelayMilliseconds;
  final EdgeInsetsGeometry? padding;
  final SliverGridDelegate gridDelegate;
  final Widget? initialWidget;
  final Widget? addMoreButton;
  final Widget? viewAllImagesButton;
  final BoxDecoration? onDragBoxDecoration;
  final Widget Function(BuildContext context, ImageFile imageFile)? builder;

  @override
  State<MultiImagePickerView> createState() => _MultiImagePickerViewState();
}

class _MultiImagePickerViewState extends State<MultiImagePickerView> {
  late final ScrollController _scrollController;
  final _gridViewKey = GlobalKey();
  List<ImageFile> imageFileList = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.controller.addListener(_updateUi);
  }

  bool get _showAddMoreButton =>
      widget.addMoreButton != null &&
      widget.controller.images.length < widget.controller.maxImages;

  bool get _showViewAlButton =>
      widget.viewAllImagesButton != null && imageFileList.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    imageFileList = widget.controller.images.toList();
    final initialWidget = widget.initialWidget;
    final addMoreButton = SizedBox(
      key: Key('${_gridViewKey}_add_btn'),
      child: widget.addMoreButton,
    );
    final viewAllImagesButton = SizedBox(
      key: Key('${_gridViewKey}_view_all'),
      child: widget.viewAllImagesButton,
    );
    if (widget.controller.hasNoImages) {
      if (initialWidget == null) return const SizedBox();
      if (!widget.shrinkWrap) {
        return Column(children: [initialWidget]);
      }
      return initialWidget;
    }

    return GridView(
      key: _gridViewKey,
      shrinkWrap: widget.shrinkWrap,
      controller: _scrollController,
      padding: widget.padding ?? EdgeInsets.zero,
      gridDelegate: widget.gridDelegate,
      children: [
        if (imageFileList.isEmpty)
          const SizedBox.shrink()
        else
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ImageFileView(
              fit: BoxFit.cover,
              imageFile: imageFileList.first,
            ),
          ),
        if (_showViewAlButton) viewAllImagesButton,
        if (_showAddMoreButton) addMoreButton
      ],
    );
  }

  @override
  void didUpdateWidget(MultiImagePickerView? oldWidget) {
    if (oldWidget == null) return;
    if (widget.controller != oldWidget.controller) {
      _migrate(widget.controller, oldWidget.controller, _updateUi);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _migrate(Listenable a, Listenable b, void Function() listener) {
    b.removeListener(listener);
    a.addListener(listener);
  }

  void _updateUi() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateUi);
    _scrollController.dispose();
    super.dispose();
  }
}



