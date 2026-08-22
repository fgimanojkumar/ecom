import 'dart:convert';

import 'package:get/get.dart';

import '../../models/requests/request_tcs_claim_list.dart';
import '../../models/response/response_tcs_single_claim.dart';
import '../api_endpoint.dart';

import '../../../environment/environment.dart';
import '../http_headers.dart';

class ClaimNetworkProvider extends GetConnect {
  ClaimNetworkProvider() {
    timeout = Duration(minutes: Environment().config!.timeout);
  }

  String? baseurl = Environment().config?.baseurl;

  /// DOWNLOAD CLAIM LIST
  Future<dynamic> downloadTcsClaimList({
    required RequestTCSClaimList payload,
    required Function(List<ResponseTCSSingleClaim> claimList) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().tcsClaimList);

      final res = await post(
        resourcesUrl,
        payload.toJson(),
        headers: await getHttpHeaders(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.body['payload']);
        if (responseDataJson['data']['errorCode'] == 0 ||
            responseDataJson['data']['errorCode'] == 100) {
          Iterable dataList = responseDataJson['data']['claimDetailsObjArr'];

          List<ResponseTCSSingleClaim> tcsClaimList =
              List<ResponseTCSSingleClaim>.from(dataList.map(
            (singleItem) => ResponseTCSSingleClaim.fromJson(singleItem),
          ));

          onSuccess(tcsClaimList);
        } else {
          onFailed(responseDataJson['data']['errorDescription']);
          return;
        }
      } else if (res.statusCode == 401) {
        onFailed('Session expired. Unauthorized access!');
        return;
      }
    } catch (e) {
      onFailed('Failed to get claim list!');
      return;
    }
  }
}
