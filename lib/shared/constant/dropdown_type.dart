class DropdownType {
  DropdownType._internal();

  static final DropdownType _instance = DropdownType._internal();

  factory DropdownType() {
    return _instance;
  }

  final String dLCategory = 'dLCategory';
  final String dLType = 'dLType';
  final String driverRelation = 'driverRelation';
  final String color = 'color';
  final String modeOfTransport = 'modeOfTransport';
  final String whoIsDriving = 'whoIsDriving';
  final String accountType = 'accountType';
  final String claimSubStatus = 'claimSubStatus';
  final String partType = 'partType';
  final String claimSettlementType = 'claimSettlementType';

  final List<String> sacPercentage = ['0', '5', '12', '18', '28'];
  final List<String> sacCode = ['56700012', '56700013', '56700014', '56700015'];
  final List<String> ocrType = ['Parts', 'Labour', 'Summary'];
  final List<String> paymentMode = [
    'Select',
    'NEFT',
    'DD',
    'E-Cheque',
    'IMPS',
    'Manual Cheque',
    'RTGS'
  ];
}
