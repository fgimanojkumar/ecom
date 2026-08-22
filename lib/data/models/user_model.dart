class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final List<Address> addresses;
  final List<String> wishlist;
  final int loyaltyPoints;
  final String referralCode;
  final DateTime joinDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.addresses,
    required this.wishlist,
    required this.loyaltyPoints,
    required this.referralCode,
    required this.joinDate,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    List<Address>? addresses,
    List<String>? wishlist,
    int? loyaltyPoints,
    String? referralCode,
    DateTime? joinDate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      addresses: addresses ?? this.addresses,
      wishlist: wishlist ?? this.wishlist,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      referralCode: referralCode ?? this.referralCode,
      joinDate: joinDate ?? this.joinDate,
    );
  }
}

class Address {
  final String id;
  final String name;
  final String phone;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final bool isDefault;
  final String addressType; // home, work, etc

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    this.isDefault = false,
    this.addressType = 'home',
  });

  String get fullAddress => '$street, $city, $state - $pincode';

  Address copyWith({
    String? id,
    String? name,
    String? phone,
    String? street,
    String? city,
    String? state,
    String? pincode,
    bool? isDefault,
    String? addressType,
  }) {
    return Address(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      isDefault: isDefault ?? this.isDefault,
      addressType: addressType ?? this.addressType,
    );
  }
}
