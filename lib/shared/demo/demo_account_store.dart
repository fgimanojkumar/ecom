import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../flutterStorage/flutter_storage_keys.dart';
import '../localStorage/local_storage.dart';

class DemoAccountStore {
  DemoAccountStore._();

  static const demoEmail = 'demo@bhabsa.com';
  static const demoPassword = 'Bhabsa@123';
  static const demoMobile = '9876543210';
  static const demoOtp = '1234';
  static const demoUserId = 'demo-user-001';

  static final List<Map<String, dynamic>> users = [
    {
      'id': demoUserId,
      'name': 'Aarav Sharma',
      'email': demoEmail,
      'phone': demoMobile,
      'password': demoPassword,
      'loyaltyPoints': 0,
      'paymentCards': <Map<String, dynamic>>[],
      'addresses': <Map<String, dynamic>>[
        {
          'id': '1',
          'type': 'Home',
          'name': 'Aarav Sharma',
          'phone': demoMobile,
          'street': '42 Green Park Road',
          'city': 'New Delhi',
          'state': 'Delhi',
          'pincode': '110016',
          'isDefault': true,
        },
        {
          'id': '2',
          'type': 'Office',
          'name': 'Aarav Sharma',
          'phone': demoMobile,
          'street': '18 Connaught Place',
          'city': 'New Delhi',
          'state': 'Delhi',
          'pincode': '110001',
          'isDefault': false,
        },
      ],
      'orders': <Map<String, dynamic>>[
        {
          'id': 'ORD-DEMO-1001',
          'date': '2026-09-22',
          'items': 2,
          'total': 3498.0,
          'status': 'Delivered',
          'statusColor': 'green',
          'image': 'resources/images/login_img.png',
          'addressId': '1',
          'paymentMethod': 'UPI',
          'subtotal': 2964.0,
          'shipping': 50.0,
          'tax': 484.0,
          'lines': <Map<String, dynamic>>[
            {
              'name': 'Premium Wireless Headphones',
              'image': 'resources/images/login_img.png',
              'qty': 1,
              'price': 2499.0,
            },
            {
              'name': 'Leather Wallet',
              'image': 'resources/images/login_img.png',
              'qty': 1,
              'price': 465.0,
            },
          ],
        },
        {
          'id': 'ORD-DEMO-1002',
          'date': '2026-09-29',
          'items': 1,
          'total': 1299.0,
          'status': 'In Transit',
          'statusColor': 'blue',
          'image': 'resources/images/login_img.png',
          'addressId': '2',
          'paymentMethod': 'Card',
          'subtotal': 1100.0,
          'shipping': 50.0,
          'tax': 149.0,
          'lines': <Map<String, dynamic>>[
            {
              'name': 'Everyday Backpack',
              'image': 'resources/images/login_img.png',
              'qty': 1,
              'price': 1100.0,
            },
          ],
        },
      ],
    },
  ];

  static final Rxn<Map<String, dynamic>> activeUser =
      Rxn<Map<String, dynamic>>();
  static Map<String, dynamic>? latestOrder;

  static Map<String, dynamic> get demoUser => users.first;

  static int get loyaltyPoints {
    final value = (activeUser.value ?? demoUser)['loyaltyPoints'];
    return value is num ? value.toInt() : 0;
  }

  static List<Map<String, dynamic>> get addresses =>
      (activeUser.value ?? demoUser)['addresses'] as List<Map<String, dynamic>>;

  static List<Map<String, dynamic>> get orders =>
      (activeUser.value ?? demoUser)['orders'] as List<Map<String, dynamic>>;

  static String formatAddress(Map<String, dynamic> address) {
    return [
      address['street'],
      address['building'],
      address['landmark'],
      address['city'],
      address['state'],
      address['pincode'],
    ]
        .where((part) => part != null && part.toString().trim().isNotEmpty)
        .map((part) => part.toString().trim())
        .join(', ');
  }

  static bool hasValidPasswordCredentials(String identifier, String password) {
    final account = _findUser(identifier);
    return account != null && account['password'] == password;
  }

  static bool hasValidOtpCredentials(String mobile, String otp) {
    final account = _findUser(mobile);
    return account != null && otp == demoOtp;
  }

  static Future<String?> registerDemoAccount({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedPhone = phone.replaceAll(RegExp(r'\D'), '');
    if (_findUser(normalizedEmail) != null ||
        _findUser(normalizedPhone) != null) {
      return 'An account with this email or mobile number already exists.';
    }

    final account = <String, dynamic>{
      'id': 'demo-user-${DateTime.now().microsecondsSinceEpoch}',
      'name': name.trim(),
      'email': normalizedEmail,
      'phone': normalizedPhone,
      'password': password,
      'loyaltyPoints': 0,
      'paymentCards': <Map<String, dynamic>>[],
      'addresses': <Map<String, dynamic>>[],
      'orders': <Map<String, dynamic>>[],
    };
    users.add(account);
    await _startSession(account);
    return null;
  }

  static Future<bool> signInWithPassword({
    required String identifier,
    required String password,
  }) async {
    if (!hasValidPasswordCredentials(identifier, password)) return false;
    final account = _findUser(identifier)!;
    await _startSession(account);
    return true;
  }

  static Future<bool> signInWithOtp({
    required String mobile,
    required String otp,
  }) async {
    if (!hasValidOtpCredentials(mobile, otp)) return false;
    final account = _findUser(mobile)!;
    await _startSession(account);
    return true;
  }

  static Future<Map<String, dynamic>?> restoreSession() async {
    final localStorage = LocalStorage();
    final userId = await localStorage.getLocalStorage(
          FlutterStorageKeys().userId,
        ) ??
        (!kIsWeb
            ? await const FlutterSecureStorage().read(
                key: FlutterStorageKeys().userId,
              )
            : null);
    final token = kIsWeb
        ? await localStorage.getLocalStorage(FlutterStorageKeys().token)
        : await const FlutterSecureStorage().read(
              key: FlutterStorageKeys().token,
            ) ??
            await localStorage.getLocalStorage(FlutterStorageKeys().token);

    if (token == null || userId == null) {
      activeUser.value = null;
      return null;
    }

    for (final user in users) {
      if (user['id'] == userId) {
        activeUser.value = user;
        return user;
      }
    }

    activeUser.value = null;
    return null;
  }

  static Future<void> signOut() async {
    final keys = FlutterStorageKeys();
    await LocalStorage().removeStorageItem(keys.userId);
    await LocalStorage().removeStorageItem(keys.token);
    if (!kIsWeb) {
      await const FlutterSecureStorage().delete(key: keys.userId);
      await const FlutterSecureStorage().delete(key: keys.token);
    }
    activeUser.value = null;
  }

  static Map<String, dynamic> recordOrder({
    required int itemCount,
    required double subtotal,
    required double shipping,
    required double tax,
    required double total,
    required String addressId,
    String? billingAddressId,
    required String paymentMethod,
    required List<Map<String, dynamic>> lines,
  }) {
    final order = <String, dynamic>{
      'id': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      'date': DateTime.now().toIso8601String().substring(0, 10),
      'items': itemCount,
      'subtotal': subtotal,
      'shipping': shipping,
      'tax': tax,
      'total': total,
      'status': 'Processing',
      'statusColor': 'orange',
      'image': lines.isEmpty
          ? 'resources/images/login_img.png'
          : lines.first['image'],
      'addressId': addressId,
      'billingAddressId': billingAddressId ?? addressId,
      'paymentMethod': paymentMethod,
      'lines': lines,
    };
    orders.insert(0, order);
    latestOrder = order;
    return order;
  }

  static void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    final user = activeUser.value ?? demoUser;
    user['name'] = name;
    user['email'] = email.toLowerCase();
    var normalizedPhone = phone.replaceAll(RegExp(r'\D'), '');
    if (normalizedPhone.length > 10) {
      normalizedPhone = normalizedPhone.substring(normalizedPhone.length - 10);
    }
    user['phone'] = normalizedPhone;
    activeUser.refresh();
  }

  static Map<String, dynamic>? _findUser(String identifier) {
    final normalized = identifier.trim().toLowerCase();
    for (final user in users) {
      final phoneDigits = normalized.replaceAll(RegExp(r'\D'), '');
      if ((user['email'] as String).toLowerCase() == normalized ||
          user['phone'] == phoneDigits) {
        return user;
      }
    }
    return null;
  }

  static Future<void> _startSession(Map<String, dynamic> user) async {
    final keys = FlutterStorageKeys();
    final token = 'demo-session-${user['id']}';
    await LocalStorage().setLocalStorage(keys.userId, user['id'] as String);
    await LocalStorage().setLocalStorage(keys.token, token);
    if (!kIsWeb) {
      await const FlutterSecureStorage()
          .write(key: keys.userId, value: user['id'] as String);
      await const FlutterSecureStorage().write(key: keys.token, value: token);
    }
    activeUser.value = user;
  }
}
