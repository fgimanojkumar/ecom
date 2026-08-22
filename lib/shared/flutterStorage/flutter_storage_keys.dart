class FlutterStorageKeys {
  FlutterStorageKeys._internal();

  static final FlutterStorageKeys _instance = FlutterStorageKeys._internal();

  factory FlutterStorageKeys() {
    return _instance;
  }

  final String loginDetails = 'loginDetails';
  final String loginPin = 'loginPin';

  final String isBiometricEnabled = 'isBiometricEnabled';
  final String token = 'token';
  final String userId = 'userId';
  final String username = 'username';
  final String surveyorCode = 'surveyorCode';
  final String lateMasterSyncDate = 'lateMasterSyncDate';
}
