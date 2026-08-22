class UiString {
  UiString._internal();

  static final UiString _instance = UiString._internal();

  factory UiString() {
    return _instance;
  }

  final String linkShareMessage = 'Digital claim form link';
  final String somethingWentWrong = 'Something went wrong. Please try again!';
  final String loginAlert =
      'Set your app PIN, you’ll use it to quickly and securely log in to the app next time.';
  final String surveyorCodeAlert =
      'Surveyor code is not mapped to your login. Please contact admin for more details!';
  final String invalidLoginAlert =
      'The username or password you entered is incorrect. Please try again with valid credentials!';
  final String formValidationValue =
      'Input values are not correct please check and update correct values!';
  final String paymentScreenNote =
      'Note: Above values are including TAX less depreciation assessed without prejudice and subject to terms and condition of the policy.';
  final String surveyCompletionAlert =
      'Are you sure you want to finalize this survey?';

  final String lockSectionErrorMessage =
      'Section is locked for edit; as payment or final summary complete for this claim!';
}
