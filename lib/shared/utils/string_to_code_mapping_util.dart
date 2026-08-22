class StringToCodeMappingUtil {
  StringToCodeMappingUtil._internal();

  static final StringToCodeMappingUtil _instance =
      StringToCodeMappingUtil._internal();

  factory StringToCodeMappingUtil() {
    return _instance;
  }

  getSettlementTypeToCode(String fullString) {
    if (fullString == 'Cash loss with policy cancellation') {
      return 'CWPC';
    } else if (fullString == 'Cash loss without policy cancellation') {
      return 'CLWPC';
    } else if (fullString == 'FX+') {
      return 'FX';
    } else if (fullString == 'Net of Salvage') {
      return 'NOS';
    } else if (fullString == 'Partial Theft') {
      return 'PT';
    } else if (fullString == 'Repairs') {
      return 'R';
    } else if (fullString == 'Total Loss') {
      return 'TL';
    } else if (fullString == 'Without bill settlement (FX+) settlement') {
      return 'WBS';
    }
    return fullString;
  }

  // DD,NEFT,E-Cheque,IMPS,Manual Cheque,RTGS
  getPaymentModeToCode(String fullString) {
    if (fullString == 'NEFT') {
      return 'A';
    }
    if (fullString == 'DD') {
      return 'DD';
    }
    if (fullString == 'E-Cheque') {
      return 'E';
    }
    if (fullString == 'IMPS') {
      return 'I';
    }
    if (fullString == 'Manual Cheque') {
      return 'MC';
    }
    if (fullString == 'RTGS') {
      return 'R';
    }
    return fullString;
  }

  getExpenseReserveCode(String fullString) {
    if (fullString == 'Case Management Fee') {
      return 'CFEE';
    } else if (fullString == 'Expert Opinion') {
      return 'EXOPN';
    } else if (fullString == 'Investigation Fee') {
      return 'INFEE';
    } else if (fullString == 'Lawyer Fee') {
      return 'LAWFEE';
    } else if (fullString == 'Legal Fee') {
      return 'LFEE';
    } else if (fullString == 'Medical Record Retrieval Fee') {
      return 'MRRFEE';
    } else if (fullString == 'Other Expenses') {
      return 'OTHER';
    } else if (fullString == 'Professional Fee') {
      return 'PFEE';
    } else if (fullString == 'Super Expert Opinion') {
      return 'SEOPN';
    } else if (fullString == 'Surveyor Fee') {
      return 'SFEE';
    } else if (fullString == 'Translation fee') {
      return 'TRANSFEE';
    }
    return fullString;
  }
}
