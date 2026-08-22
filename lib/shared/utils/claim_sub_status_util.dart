class ClaimSubStatusUtil {
  ClaimSubStatusUtil._internal();

  static final ClaimSubStatusUtil _instance = ClaimSubStatusUtil._internal();

  factory ClaimSubStatusUtil() {
    return _instance;
  }

  getShortName(String subStatus) {
    if (subStatus == 'Work Order Given') {
      return 'WOG';
    } else if (subStatus == 'Surveyor Appointed') {
      return 'SA';
    } else if (subStatus == 'Survey Completion') {
      return 'SC';
    } else if (subStatus == 'On Account Payment Requested') {
      return 'OAPR';
    } else if (subStatus == 'Claim Closure Approved') {
      return 'CCA';
    } else if (subStatus == 'Approved QC') {
      return 'APPQC';
    } else if (subStatus == 'Approved - Technical Approval' ||
        subStatus == 'Approved- Technical Approval') {
      return 'ATA';
    } else if (subStatus == 'Pending for Surveyor Deputation') {
      return 'PSD';
    } else if (subStatus == 'Claim Re-opened') {
      return 'REOPEN';
    } else if (subStatus == 'Under Technical Approval') {
      return 'UTA';
    } else if (subStatus == 'Rejected - Technical Approval') {
      return 'RTA';
    } else if (subStatus == 'Claim Closure Rejected') {
      return 'CCR';
    } else if (subStatus == 'Investigator Deputed') {
      return 'ID';
    } else if (subStatus == 'Manual Closure Initiated') {
      return 'MANUAL';
    } else if (subStatus == 'On Account Payment Approved') {
      return 'OAPR';
    } else if (subStatus == 'Pending for Investiagtion deputation') {
      return 'PID';
    } else if (subStatus == 'Reject FCU Initiated Request') {
      return 'RFIR';
    } else if (subStatus == 'Technical Assessment') {
      return 'TECHASS';
    } else if (subStatus == 'Approve FCU Initiated Request') {
      return 'AFIR';
    }
    return subStatus;
  }

  getFullName(String subStatus) {
    if (subStatus == 'WOG') {
      return 'Work Order Given';
    } else if (subStatus == 'SA') {
      return 'Surveyor Appointed';
    } else if (subStatus == 'SC') {
      return 'Survey Completion';
    } else if (subStatus == 'OAPR') {
      return 'On Account Payment Requested';
    } else if (subStatus == 'CCA') {
      return 'Claim Closure Approved';
    } else if (subStatus == 'APPQC') {
      return 'Approved QC';
    } else if (subStatus == 'ATA') {
      return 'Approved- Technical Approval';
    } else if (subStatus == 'PSD') {
      return 'Pending for Surveyor Deputation';
    } else if (subStatus == 'REOPEN') {
      return 'Claim Re-opened';
    } else if (subStatus == 'UTA') {
      return 'Under Technical Approval';
    } else if (subStatus == 'RTA') {
      return 'Rejected - Technical Approval';
    } else if (subStatus == 'CCR') {
      return 'Claim Closure Rejected';
    } else if (subStatus == 'ID') {
      return 'Investigator Deputed';
    } else if (subStatus == 'MANUAL') {
      return 'Manual Closure Initiated';
    } else if (subStatus == 'OAPR') {
      return 'On Account Payment Approved';
    } else if (subStatus == 'PID') {
      return 'Pending for Investigation Deputation';
    } else if (subStatus == 'RFIR') {
      return 'Reject FCU Initiated Request';
    } else if (subStatus == 'TECHASS') {
      return 'Technical Assessment';
    } else if (subStatus == 'AFIR') {
      return 'Approve FCU Initiated Request';
    }
    return subStatus;
  }
}
