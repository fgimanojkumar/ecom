import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';

import '../style/app_style.dart';
import 'exit_app_pop_up.dart';

Widget notificationEmptyPopup() {
  double itemHeight = 45;
  double itemFontSize = 14;
  double itemIconSize = 20;
  Color itemIconColor = AppColors.black1;
  return SingleChildScrollView(
    child: PopupMenuButton(
      constraints: const BoxConstraints.expand(width: 330, height: 350),
      elevation: 10,
      tooltip: 'Notifications',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      splashRadius: 40.0,
      icon: const Icon(
        Icons.notification_important_rounded,
        size: 20,
        color: AppColors.white,
      ),
      position: PopupMenuPosition.under,
      color: AppColors.white,
      surfaceTintColor: AppColors.white,
      onSelected: (value) {},
      itemBuilder: (BuildContext bc) {
        return [
          PopupMenuItem(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, right: 8, left: 8),
            height: itemHeight,
            value: '/',
            enabled: true,
            child: SizedBox(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.notifications_none,
                      size: itemIconSize, color: itemIconColor),
                  Text(
                    'Notification',
                    style: TextStyle(
                        fontSize: itemFontSize, color: AppColors.black1),
                  ),
                  Icon(Icons.cancel_outlined,
                      size: itemIconSize, color: itemIconColor),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, right: 8, left: 8),
            height: itemHeight,
            value: '/',
            enabled: true,
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset(
                          'resources/images/notification-ball.png')),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Nothing here !!',
                    style: TextStyle(fontSize: 16, color: AppColors.black2),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Tap tha notification setting  button below\n and check again',
                    maxLines: 3,
                    style: TextStyle(fontSize: 12, color: AppColors.black1),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
    ),
  );
}

Widget notificationPopup() {
  double itemHeight = 45;
  double itemFontSize = 14;
  double itemIconSize = 20;
  Color itemIconColor = AppColors.blackHeading;
  return SingleChildScrollView(
    child: PopupMenuButton(
      constraints: const BoxConstraints.expand(width: 330, height: 350),
      elevation: 10,
      tooltip: 'Notifications',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      splashRadius: 40.0,
      icon: const Icon(
        Icons.notification_important_rounded,
        size: 20,
        color: AppColors.white,
      ),
      position: PopupMenuPosition.under,
      color: AppColors.white,
      surfaceTintColor: AppColors.white,
      onSelected: (value) {},
      itemBuilder: (BuildContext bc) {
        return [
          PopupMenuItem(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, right: 8, left: 8),
            height: itemHeight,
            value: '/',
            enabled: true,
            child: SizedBox(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.notifications_none,
                      size: itemIconSize, color: itemIconColor),
                  Text(
                    'Notification',
                    style: TextStyle(
                        fontSize: itemFontSize, color: AppColors.black2),
                  ),
                  Icon(Icons.cancel_outlined,
                      size: itemIconSize, color: itemIconColor),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(8),
            height: itemHeight,
            value: '/',
            child: SizedBox(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Image.asset('resources/images/profile.png')),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, right: 85),
                        child: Text(
                          'Validation Failed ',
                          style: TextStyle(
                            color: AppColors.black2,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              color: AppColors.primary1,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: const Text(
                      'It is a long establishedIt is a long established long established It is a long established',
                      style: TextStyle(fontSize: 12),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '12 Jan 2024 05:46 AM',
                          style: TextStyle(
                            color: AppColors.black1,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(8),
            height: itemHeight,
            value: '/',
            child: SizedBox(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset('resources/images/profile.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, right: 85),
                        child: Text(
                          'Validation Failed ',
                          style: TextStyle(
                            color: AppColors.black2,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                                color: AppColors.primary1,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: const Text(
                      'It is a long establishedIt is a long established long established. It is a long established.',
                      style: TextStyle(fontSize: 12),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '12 Jan 2024 05:46 AM',
                          style: TextStyle(
                              color: AppColors.blackHeading,
                              fontSize: 9,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(8),
            height: itemHeight,
            value: '/',
            child: SizedBox(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset('resources/images/profile.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, right: 85),
                        child: Text(
                          'Validation Failed ',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                                color: AppColors.primary1,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: const Text(
                      'It is a long establishedIt is a long established long established. It is a long established',
                      style: TextStyle(fontSize: 12),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '12 Jan 2024 05:46 AM',
                          style: TextStyle(
                              color: AppColors.black2,
                              fontSize: 9,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(8),
            height: itemHeight,
            value: '/',
            child: SizedBox(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Image.asset('resources/images/profile.png')),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, right: 85),
                        child: Text(
                          'Validation Failed ',
                          style: TextStyle(
                              color: AppColors.black2,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              color: AppColors.primary1,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: const Text(
                      'It is a long establishedIt is a long established long established It is a long established',
                      style: TextStyle(fontSize: 12),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '12 Jan 2024 05:46 AM',
                          style: TextStyle(
                              color: AppColors.black1,
                              fontSize: 9,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ];
      },
    ),
  );
}

Widget profilePopup(
  String username,
  String surveyorCode,
  String userId,
) {
  double itemHeight = 35;
  double itemFontSize = 14;
  double itemIconSize = 20;

  return PopupMenuButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    splashRadius: 40.0,
    tooltip: username,
    color: AppColors.white,
    position: PopupMenuPosition.under,
    surfaceTintColor: AppColors.white,
    onSelected: (value) {},
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: InkWell(
            onTap: () => {
              // Get.toNamed(AppRoutes().profile),
            },
            child: Text(
              '$username '
              ' | '
              ' $userId  \nSurveyor Code : $surveyorCode',
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          height: itemHeight,
          value: '/',
          child: SizedBox(
            width: 200,
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  size: itemIconSize,
                  color: AppColors.primary1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: itemFontSize,
                      color: AppColors.primary1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            // appController.logoutConfirm();
            exitApp(context);
          },
        ),
      ];
    },
    child: Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('resources/images/profile.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: SizedBox(
            width: 70.0,
            child: Text(
              // "Username",
              username,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 0, right: 25),
          child:
              // profilePopup(),
              Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.white,
          ),
        ),
      ],
    ),
  );
}



