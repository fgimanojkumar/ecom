import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../style/app_style.dart';

class AppLoader {
  AppLoader._();

  static void popUpLoader(context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: AppColors.black.withValues(alpha: 0.18),
      context: context,
      builder: (_) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: LoadingAnimationWidget.inkDrop(
              size: 40,
              color: AppColors.primary1,
            ),
          ),
        );
      },
    );
  }

  static Widget onScreenLoader() {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        size: 40,
        color: AppColors.primary1,
      ),
    );
  }

  static Widget onScreenLoaderWithScaffold() {
    return Scaffold(
      backgroundColor: AppColors.body,
      body: Center(
        child: LoadingAnimationWidget.inkDrop(
          size: 40,
          color: AppColors.primary1,
        ),
      ),
    );
  }
}

class AppLoaderRouteObserver extends NavigatorObserver {
  static const _minimumDisplayTime = Duration(milliseconds: 360);

  OverlayEntry? _loaderEntry;
  Timer? _hideTimer;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PopupRoute) return;
    _showLoader();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PopupRoute) return;
    _showLoader();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PopupRoute) return;
    _showLoader();
  }

  void _showLoader() {
    _hideTimer?.cancel();
    _loaderEntry?.remove();

    final overlay = navigator?.overlay;
    if (overlay == null) return;

    _loaderEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          ModalBarrier(
            color: AppColors.white.withOpacity(0.78),
            dismissible: false,
          ),
          AppLoader.onScreenLoader(),
        ],
      ),
    );
    overlay.insert(_loaderEntry!);
    _hideTimer = Timer(_minimumDisplayTime, _hideLoader);
  }

  void _hideLoader() {
    _loaderEntry?.remove();
    _loaderEntry = null;
    _hideTimer = null;
  }
}
