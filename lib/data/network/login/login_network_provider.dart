import 'dart:convert';

import 'package:get/get_connect/connect.dart';

import '../../../environment/environment.dart';
import '../../../shared/constant/ui_string.dart';
import '../../models/login/request_create_app_pin.dart';
import '../../models/login/request_login.dart';
import '../../models/login/request_login_with_pin.dart';
import '../../models/login/response_login.dart';
import '../api_endpoint.dart';
import '../http_headers.dart';

/// INDEX
/// 1. userLogin() : User login
/// 2. loginWithPin() : login With Pin
/// 3. CreateAppPin() : Set or Update pin

class LoginNetworkProvider extends GetConnect {
  LoginNetworkProvider() {
    timeout = Duration(minutes: Environment().config!.timeout);
  }

  String? baseurl = Environment().config?.baseurl;

  /// 1. userLogin() : User login
  Future<dynamic> userLogin({
    required RequestLogin body,
    required Function(ResponseLogin resMember, RequestLogin body) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().login);

      final res = await post(
        resourcesUrl,
        body.toJson(),
        headers: await getHttpHeaders(),
      );

      if (res.statusCode == 200 || res.statusCode == 400) {
        var jsonData = jsonDecode(res.bodyString ?? '');
        if (jsonData['success'] ?? false) {
          ResponseLogin responseLogin =
              ResponseLogin.fromJson(jsonData['payload']);
          if (responseLogin.surveyorCode == null) {
            onFailed(UiString().surveyorCodeAlert);
          } else {
            onSuccess(responseLogin, body);
          }
          return;
        } else {
          onFailed(jsonData['message']);
          return;
        }
      } else {
        onFailed(UiString().somethingWentWrong);
        return;
      }
    } catch (e) {
      onFailed(UiString().somethingWentWrong);
    }
  }

  /// 2. loginWithPin() : login With Pin
  Future<dynamic> loginWithPin({
    required RequestLoginWithPin body,
    required Function(ResponseLogin resMember, RequestLoginWithPin body)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().loginWithPin);

      final res = await post(
        resourcesUrl,
        body.toJson(),
        headers: await getHttpHeaders(),
      );

      if (res.statusCode == 200 || res.statusCode == 400) {
        var jsonData = jsonDecode(res.bodyString ?? '');
        if (jsonData['success'] ?? false) {
          onSuccess(ResponseLogin.fromJson(jsonData['payload']), body);
          return;
        } else {
          onFailed(jsonData['message']);
          return;
        }
      } else {
        onFailed(UiString().somethingWentWrong);
        return;
      }
    } catch (e) {
      onFailed(UiString().somethingWentWrong);
    }
  }

  /// 3. CreateAppPin() : Set or Update pin
  Future<dynamic> createAppPin({
    required RequestCreateAppPin body,
    required Function(String success) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().createAppPin);

      final res = await post(
        resourcesUrl,
        body.toJson(),
        headers: await getHttpHeaders(),
      );

      if (res.statusCode == 200 || res.statusCode == 400) {
        var jsonData = jsonDecode(res.bodyString ?? '');
        if (jsonData['success'] ?? false) {
          onSuccess('success');
          return;
        } else {
          onFailed(jsonData['message']);
          return;
        }
      } else {
        onFailed(UiString().somethingWentWrong);
        return;
      }
    } catch (e) {
      onFailed(UiString().somethingWentWrong);
    }
  }
}
