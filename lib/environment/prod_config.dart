import 'environment.dart';

import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiClient => 'MOBILE';

  @override
  String get env => Environment.PROD;

  @override
  String get baseurl => 'https://congoprodapp.azurewebsites.net';

  @override
  String get defaultToken => '';

  @override
  bool get reportErrors => false;

  @override
  int get timeout => 1;
}
