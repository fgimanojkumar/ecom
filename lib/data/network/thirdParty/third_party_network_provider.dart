import 'dart:convert';

import 'package:get/get.dart';

import '../../../environment/environment.dart';
import '../../../shared/constant/ui_string.dart';
import '../../../shared/flutterStorage/flutter_storage_keys.dart';
import '../../../shared/localStorage/local_storage.dart';
import '../api_endpoint.dart';
import '../custom_get_connect.dart';
import '../http_headers.dart';

/// INDEX
/// 1. GenerateIcrOcrAccessTokenAsync() : Generate token
/// 2. DigitalInvoiceICR() : Digital Invoice OCR
/// 3. CreateAppPin() : Set or Update pin

class ThirdPartyNetworkProvider extends GetConnect {
  ThirdPartyNetworkProvider() {
    timeout = Duration(minutes: Environment().config!.timeout);
  }

  String? baseurl = Environment().config?.baseurl;

  /// 1. GenerateIcrOcrAccessTokenAsync() : Generate token
  Future<dynamic> generateIcrOcrAccessToken({
    required Function(String token) onSuccess,
    required Function(String error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().generateOcrToken);

      final res = await post(
        resourcesUrl,
        {},
        headers: await getHttpHeaders(),
      );

      if (res.statusCode == 200 || res.statusCode == 400) {
        if (res.body['success']) {
          var responseDataJson = jsonDecode(res.body['payload']);
          onSuccess(responseDataJson['access_token']);
          return;
        } else {
          onFailed(res.body['message']);
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

  /// 2. DigitalInvoiceICR() : Digital Invoice OCR
  Future<dynamic> uploadDigitalInvoiceICR({
    required FormData uploadFormData,
    required String token,
    required Function(String success) onSuccess,
    required Function(String error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().digitalInvoiceICR);
      resourcesUrl = '$resourcesUrl?accToken=$token';

      final connect = CustomGetConnect();
      String? xAuthToken =
          await LocalStorage().getLocalStorage(FlutterStorageKeys().token);

      connect.httpClient.addRequestModifier<Object?>((request) async {
        request.headers['Authorization'] = 'Bearer $xAuthToken';
        return request;
      });

      final res = await connect.post(resourcesUrl, uploadFormData);

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString!);
        if (responseDataJson['success']) {
          onSuccess(responseDataJson['payload']);
          return;
        } else {
          onFailed(responseDataJson['message']);
          return;
        }
      } else {
        onFailed('Fail to upload document!');
        return;
      }
    } catch (e) {
      onFailed('Fail to upload document!');
      return;
    }
  }
}
