class OCRUploadResponse {
  String? chassisNo;
  String? colorOfVehicle;
  String? customerName;
  String? engineNo;
  String? gSTINNo;
  String? insurerGSTINNo;
  String? invoiceDate;
  String? invoiceNo;
  List<LineItem>? lineItem;
  String? make;
  String? modelName;
  String? registrationNo;
  String? stateCode;
  String? taxableAmount;
  String? totalAmount;
  String? typeOfOem;

  OCRUploadResponse({
    this.chassisNo,
    this.colorOfVehicle,
    this.customerName,
    this.engineNo,
    this.gSTINNo,
    this.insurerGSTINNo,
    this.invoiceDate,
    this.invoiceNo,
    this.lineItem,
    this.make,
    this.modelName,
    this.registrationNo,
    this.stateCode,
    this.taxableAmount,
    this.totalAmount,
    this.typeOfOem,
  });

  OCRUploadResponse.fromJson(Map<String, dynamic> json) {
    chassisNo = json['Chassis No'];
    colorOfVehicle = json['Color of Vehicle'];
    customerName = json['Customer Name'];
    engineNo = json['Engine No'];
    gSTINNo = json['GSTIN No'];
    insurerGSTINNo = json['Insurer GSTIN No'];
    invoiceDate = json['Invoice Date'];
    invoiceNo = json['Invoice No'];
    if (json['Line Item'] != null) {
      lineItem = <LineItem>[];
      json['Line Item'].forEach((v) {
        lineItem!.add(LineItem.fromJson(v));
      });
    }
    make = json['Make'];
    modelName = json['Model Name'];
    registrationNo = json['Registration No'];
    stateCode = json['State Code'];
    taxableAmount = json['Taxable Amount'];
    totalAmount = json['Total Amount'];
    typeOfOem = json['type_of_oem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Chassis No'] = chassisNo;
    data['Color of Vehicle'] = colorOfVehicle;
    data['Customer Name'] = customerName;
    data['Engine No'] = engineNo;
    data['GSTIN No'] = gSTINNo;
    data['Insurer GSTIN No'] = insurerGSTINNo;
    data['Invoice Date'] = invoiceDate;
    data['Invoice No'] = invoiceNo;
    if (lineItem != null) {
      data['Line Item'] = lineItem!.map((v) => v.toJson()).toList();
    }
    data['Make'] = make;
    data['Model Name'] = modelName;
    data['Registration No'] = registrationNo;
    data['State Code'] = stateCode;
    data['Taxable Amount'] = taxableAmount;
    data['Total Amount'] = totalAmount;
    data['type_of_oem'] = typeOfOem;
    return data;
  }
}

class LineItem {
  String? cgst;
  String? discount;
  String? hsn;
  String? partName;
  String? partNumber;
  String? qty;
  String? sgst;
  String? taxValue;
  String? unitPrice;

  LineItem({
    this.cgst,
    this.discount,
    this.hsn,
    this.partName,
    this.partNumber,
    this.qty,
    this.sgst,
    this.taxValue,
    this.unitPrice,
  });

  LineItem.fromJson(Map<String, dynamic> json) {
    cgst = json['cgst'];
    discount = json['discount'];
    hsn = json['hsn'];
    partName = json['part_name'];
    partNumber = json['part_number'];
    qty = json['qty'];
    sgst = json['sgst'];
    taxValue = json['tax_value'];
    unitPrice = json['unit_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cgst'] = cgst;
    data['discount'] = discount;
    data['hsn'] = hsn;
    data['part_name'] = partName;
    data['part_number'] = partNumber;
    data['qty'] = qty;
    data['sgst'] = sgst;
    data['tax_value'] = taxValue;
    data['unit_price'] = unitPrice;
    return data;
  }
}
