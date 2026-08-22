extension StringValidation on String {
  bool validateVin() {
    RegExp re = RegExp(r'^[A-HJ-NPR-Z\d]{8}[\dX][A-HJ-NPR-Z\d]{2}\d{6}$');
    return re.hasMatch(this);
  }
}
