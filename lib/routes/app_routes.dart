part of 'app_pages.dart';

class AppRoutes {
  AppRoutes._internal();

  static final AppRoutes _instance = AppRoutes._internal();

  factory AppRoutes() {
    return _instance;
  }

  final String app = '/';
  final String syncMaster = '/syncMaster';
  final String login = '/login';
  final String setPin = '/set_pin';
  final String loginWithPin = '/login_with_pin';
  final String dbExample = '/db_example';

  // E-Commerce Routes
  final String splash = '/splash';
  final String onboarding = '/onboarding';
  final String signup = '/signup';
  final String forgotPassword = '/forgotPassword';
  final String home = '/home';
  final String profile = '/profile';
  final String categories = '/categories';
  final String subcategories = '/subcategories';
  final String search = '/search';
  final String productListing = '/products';
  final String productDetails = '/productDetails';
  final String reviews = '/reviews';
  final String wishlist = '/wishlist';
  final String cart = '/cart';
  final String checkout = '/checkout';
  final String address = '/address';
  final String addNewAddress = '/addNewAddress';
  final String editAddress = '/editAddress';
  final String payment = '/payment';
  final String paymentSuccess = '/paymentSuccess';
  final String orderConfirmation = '/orderConfirmation';
  final String orders = '/myOrders';
  final String orderDetails = '/orderDetails';
  final String orderTracking = '/orderTracking';
  final String returns = '/returns';
  final String coupons = '/coupons';
  final String notifications = '/notifications';
  final String chat = '/chat';
  final String help = '/help';
  final String support = '/support';
  final String loyaltyPoints = '/loyaltyPoints';
  final String referAndEarn = '/referAndEarn';
  final String recentlyViewed = '/recentlyViewed';
  final String about = '/about';
  final String privacy = '/privacy';
  final String terms = '/terms';
  final String contact = '/contact';
  final String settings = '/settings';
  final String changePassword = '/changePassword';
}
