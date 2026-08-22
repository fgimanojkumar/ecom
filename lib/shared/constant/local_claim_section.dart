class LocalClaimSection {
  LocalClaimSection._internal();

  static final LocalClaimSection _instance = LocalClaimSection._internal();

  factory LocalClaimSection() {
    return _instance;
  }

  final String assessmentType = 'assessmentType';
  final String cashless = 'cashless';
  final String claimDates = 'claimDates';
  final String docReceiveDate = 'docReceiveDate';
  final String driverDetails = 'driverDetails';
  final String insuredDetails = 'insuredDetails';
  final String invoiceNumber = 'invoiceNumber';
  final String lossInformation = 'lossInformation';
  final String modeOfPayment = 'modeOfPayment';
  final String policyDetails = 'policyDetails';
  final String riskCover = 'riskCover';
  final String salvageAmt = 'salvageAmt';
  final String splmntryAsstDetlsList = 'splmntryAsstDetlsList';
  final String splmntryAsstDetlsListFinal = 'splmntryAsstDetlsListFinal';
  final String vehicleDetails = 'vehicleDetails';
  final String journeyTracker = 'journeyTracker';

  /// AdHoc Claim Data
  final String updateExpenseReserve = 'updateExpenseReserve';
  final String neftDetails = 'neftDetails';
  final String inspectionDtlsFromImoss = 'inspectionDtlsFromImoss';
  final String requestUpdateReserve = 'requestUpdateReserve';
  final String vbStatus64 = 'vbStatus64';
  final String iibStatus = 'iibStatus';
  final String ncbStatus = 'ncbStatus';
  final String correspondenceDetails = 'correspondenceDetails';
  final String paymentDetails = 'paymentDetails';
  final String paymentRequestData = 'paymentRequestData';
}
