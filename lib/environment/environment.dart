// ignore_for_file: constant_identifier_names

import 'base_config.dart';
import 'staging_config.dart';
import 'prod_config.dart';

class Environment {
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  BaseConfig? config;

  factory Environment() {
    return _singleton;
  }

  Environment._internal();
  static final Environment _singleton = Environment._internal();

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    if (Environment.PROD == environment) {
      return ProdConfig();
    } else {
      return StagingConfig();
    }
  }
}
