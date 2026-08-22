import 'package:get/get.dart';

import '../../../data/models/requests/request_get_masters_async.dart';
import '../../../data/services/master_data_service.dart';
import '../../../shared/widgets/app_toast.dart';

class SyncController extends GetxController {
  final MasterDataService masterDataService = Get.put(MasterDataService());

  /// PART MASTER ******************* ///
  downloadPartMaster() async {
    RequestGetMastersAsync requestGetMastersAsync = RequestGetMastersAsync();
    await masterDataService.downloadMastersAndSaveToLocal(
      requestBody: requestGetMastersAsync,
      onSuccess: ((res) {
        AppToast.successToast(res);
      }),
      onFailed: (error) {
        AppToast.errorToast('Error in downloading data! $error');
      },
    );
  }
}
