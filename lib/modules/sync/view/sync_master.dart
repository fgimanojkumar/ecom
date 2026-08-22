import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_style.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/app_loader.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/sync_controller.dart';

class SyncMasterView extends GetView<SyncController> {
  const SyncMasterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PremiumAppBar(
        title: 'Sync Master',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Container(
          padding: AppPadding().pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // btnSyncMasters(context),
              gapH12,
              btnSyncPartMasters(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget btnSyncMasters(context) {
    return Padding(
      padding: AppPadding().inputPadding,
      child: ElevatedButton(
        onPressed: () {
          // controller.callSyncMasters();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary1,
          fixedSize: Size(MediaQuery.of(context).size.width, 60.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text('Sync Masters', style: AppTextStyle.btnTextStyleWhite()),
      ),
    );
  }

  Widget btnSyncPartMasters(context) {
    return Padding(
      padding: AppPadding().inputPadding,
      child: ElevatedButton(
        onPressed: () async {
          AppLoader.popUpLoader(context);
          await controller.downloadPartMaster();
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary1,
          fixedSize: Size(MediaQuery.of(context).size.width, 60.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          'Sync Part Masters',
          style: AppTextStyle.btnTextStyleWhite(),
        ),
      ),
    );
  }
}
