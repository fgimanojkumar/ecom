enum CourierStatus { active, inactive }

extension CourierStatusX on CourierStatus {
  String get label => this == CourierStatus.active ? 'Active' : 'Inactive';
}

class CourierPartner {
  final String name;
  final double avgDeliveryDays;
  final bool codAvailable;
  final CourierStatus status;

  CourierPartner({
    required this.name,
    required this.avgDeliveryDays,
    required this.codAvailable,
    required this.status,
  });
}
