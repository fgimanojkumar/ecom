class ApiEndPoints {
  ApiEndPoints._internal();

  static final ApiEndPoints _instance = ApiEndPoints._internal();

  factory ApiEndPoints() {
    return _instance;
  }

  /// LOGIN
  final String login = '/api/Authentication/login';
  final String loginWithPin = '/api/Authentication/loginWithPin';
  final String createAppPin = '/api/Authentication/CreateAppPin';

  /// THIRD PARTY API INTEGRATION
  final String generateOcrToken = '/api/Ai/GenerateIcrOcrAccessTokenAsync';
  final String digitalInvoiceICR = '/api/Ai/DigitalInvoiceICR';
  final String handwrittenInvoiceICR = '/api/Ai/HandwrittenInvoiceICR';

  final String sendClaimFormToCustomer = '/api/DigitalClaimForm/GetShortUrl';

  /// OmniDocs
  final String searchDocument = '/api/OmniDocs/SearchDocumentAsync';
  final String downloadDocument = '/api/OmniDocs/DownloadDocumentAsync';

  /// TcsBancsInquiry :: Get Data from TCS
  final String get64VBDetail = '/api/FGConnect/Get64VbStatusAsync';
  final String allMaster = '/api/TcsBancsInquiry/GetMastersAsync';
  final String tcsClaimList = '/api/TcsBancsInquiry/GetClaimListAsync';
  final String addOnForClaim = '/api/TcsBancsInquiry/GetAddonForClaimAsync';
  final String claimComments = '/api/TcsBancsInquiry/GetClaimCommentsAsync';
  final String getBankDetails = '/api/TcsBancsInquiry/GetBankDetailsAsync';
  final String getGarageDetails = '/api/TcsBancsInquiry/GetGarageDetailsAsync';
  final String getClaimHistory = '/api/TcsBancsInquiry/GetClaimHistoryAsync';
  final String getPayeeDetails = '/api/TcsBancsInquiry/GetPayeeDetailsAsync';
  final String iibEnquiryAsync = '/api/IIB/IibEnquiryAsync';

  final String getAssessmentGrid =
      '/api/TcsBancsInquiry/GetAssessmentGridAsync';
  final String getNcbRecoveryFlag =
      '/api/TcsBancsInquiry/GetNcbRecoveryFlagAsync';
  final String techApprovalRemarks =
      '/api/TcsBancsInquiry/GetTechnicalApprovalRemarksAsync';
  final String getClaimReviewComment =
      '/api/TcsBancsInquiry/GetClaimReviewCommentsAsync';
  final String assessmentSummary =
      '/api/TcsBancsInquiry/GetPriliminaryAssessmentSummaryAsync';
  final String finalAssessmentSummary =
      '/api/TcsBancsInquiry/GetFinalAssessmentSummaryAsync';

  /// TcsBancs :: Post Data to TCS
  final String uploadClaimData = '/api/TcsBancs/UploadClaimDataAsync';
  final String uploadDocument = '/api/AzureStorage/UploadDocumentAsync';
  final String saveAllComments = '/api/TcsBancs/SaveAllCommentsAsync';
  final String updateNeftDetails = '/api/TcsBancs/UpdateNeftDetailsAsync';
  final String addWorkshopDetails = '/api/TcsBancs/AddWorkshopDetailsAsync';
  final String submitSubStatus = '/api/TcsBancs/SubmitSubstatusAsync';
  final String completeSurvey = '/api/TcsBancs/CompleteSurveyAsync';
  final String sendDoSheetMail = '/api/TcsBancs/SendDoSheetMailAsync';
  final String addSurveyorDetails = '/api/TcsBancs/AddSurveyorDetailsAsync';
  final String changeStakeImoss = '/api/TcsBancs/ChangeStakeImossAsync';
  final String saveClaimReview = '/api/TcsBancs/SaveClaimReviewAsync';
  final String updateReserve = '/api/TcsBancs/UpdateReserveAsync';
  final String updateExpenseReserve = '/api/TcsBancs/UpdateExpenseReserveAsync';

  final String generatePaymentRequest =
      '/api/TcsBancs/GeneratePaymentRequestAsync';
  final String saveTechApprovalRemark =
      '/api/TcsBancs/SaveTechnicalApprovalRemarksAsync';
  final String updateInspectionDetails =
      '/api/TcsBancs/UpdateInspectionDetailsAsync';
  final String updateAssessmentExemption =
      '/api/TcsBancs/UpdateAssessmentExemptionAsync';

  /// STATIC MOCK DATA
  final String dropdownMaster = 'resources/form-json/_dropdown.json';
  final String documentMaster = 'resources/form-json/_document_type.json';

  /// FORM BUILDER JSON
  final String customInputItems = 'resources/form-json/custom_input_items.json';
  final String garageDetailsJson = 'resources/form-json/garage_details.json';

  final String singleGarageDetailsJson =
      'resources/form-json/single_garage_details.json';
}
