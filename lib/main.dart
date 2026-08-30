import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import '@config/app_config.dart';

import 'data/database/hive_adapter.dart';
import 'environment/environment.dart';
import 'init_app.dart';

void main() async {
  bootstrap(() {
    return const InitApp();
  });
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  ///*************** HIVE INITIALIZATION ***************///
  await Hive.initFlutter();
  Hive.registerAdapter(UserProfileAdapter());

  ///************ END HIVE INITIALIZATION ************///

  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.STAGING,
  );

  Environment().initConfig(environment);
  if (AppConfig.firebaseEnable) {
    await Firebase.initializeApp();
    if (Environment().config?.env == Environment.STAGING) {
      FirebaseMessaging.instance.subscribeToTopic('QA');
    } else {
      FirebaseMessaging.instance.subscribeToTopic('ALL');
    }
  }

  await runZonedGuarded(
    () async {
      runApp(await builder());
    },
    (error, stackTrace) => log(
      error.toString(),
      stackTrace: stackTrace,
    ),
  );
}
