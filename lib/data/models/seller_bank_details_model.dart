enum BankVerificationStatus { verified, pending }

extension BankVerificationStatusX on BankVerificationStatus {
  String get label => this == BankVerificationStatus.verified
      ? 'Verified'
      : 'Pending Verification';
}

class SellerBankDetails {
  String accountHolderName;
  String bankName;
  String accountNumber;
  String ifscCode;
  String branchName;
  String upiId;
  String gstNumber;
  BankVerificationStatus status;

  SellerBankDetails({
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.branchName,
    required this.upiId,
    required this.gstNumber,
    required this.status,
  });
}
