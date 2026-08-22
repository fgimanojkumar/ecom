import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/style/app_style.dart';
import '../../../shared/utils/responsive_util.dart';

class AppUpdate extends StatelessWidget {
  const AppUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Container(
          width: double.infinity,
          padding: AppPadding().pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('resources/images/app_update.png'),
              Text(
                'Time to update!'.toUpperCase(),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'We added lots of new features and\nfix some bugs to make your experience as smooth as possible !!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 200,
                child: CupertinoButton(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  onPressed: () {
                    // import 'package:url_launcher/url_launcher.dart';
                    // try {
                    //   launch("market://details?id=" + appPackageName);
                    // } on PlatformException catch(e) {
                    //     launch("https://play.google.com/store/apps/details?id=" + appPackageName);
                    // } finally {
                    //   launch("https://play.google.com/store/apps/details?id=" + appPackageName);
                    // }
                  },
                  color: AppColors.primary1,
                  child: const Text('UPDATE NOW'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
