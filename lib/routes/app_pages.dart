import 'package:get/get.dart';
import '../modules/order-details/binding/order_details_binding.dart';
import '../modules/order-details/view/order_details_view.dart';
import '../modules/product/view/product_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/view/search_view.dart';
import '../modules/splash/binding/splash_binding.dart';
import '../modules/splash/view/splash_view.dart';
import '../modules/onboarding/binding/onboarding_binding.dart';
import '../modules/onboarding/view/onboarding_view.dart';
import '../modules/signup/binding/signup_binding.dart';
import '../modules/signup/view/signup_view.dart';
import '../modules/forgotpassword/binding/forgotpassword_binding.dart';
import '../modules/forgotpassword/view/forgotpassword_view.dart';
import '../modules/home/binding/home_binding.dart';
import '../modules/home/view/home_view.dart';
import '../modules/categories/binding/categories_binding.dart';
import '../modules/categories/view/categories_view.dart';
import '../modules/subcategories/binding/sub_categories_binding.dart';
import '../modules/subcategories/view/sub_categories_view.dart';
import '../modules/invite_friends/bindings/invite_friends_binding.dart';
import '../modules/invite_friends/view/invite_friends_view.dart';
import '../modules/product/binding/product_binding.dart';
import '../modules/product_details/view/product_details_view.dart';
import '../modules/product_details/binding/product_details_binding.dart';
import '../modules/cart/binding/cart_binding.dart';
import '../modules/cart/view/cart_view.dart';
import '../modules/checkout/binding/checkout_binding.dart';
import '../modules/checkout/view/checkout_view.dart';
import '../modules/change_password/binding/change_password_binding.dart';
import '../modules/change_password/view/change_password_view.dart';
import '../modules/checkout/binding/order_confirmation_binding.dart';
import '../modules/checkout/view/order_confirmation_view.dart';
import '../modules/coupon/bindings/coupon_binding.dart';
import '../modules/coupon/view/coupon_view.dart';
import '../modules/orders/binding/orders_binding.dart';
import '../modules/orders/view/orders_view.dart';
import '../modules/wishlist/binding/wishlist_binding.dart';
import '../modules/wishlist/view/wishlist_view.dart';
import '../modules/notification/binding/notification_binding.dart';
import '../modules/notification/view/notification_view.dart';
import '../modules/address/binding/address_binding.dart';
import '../modules/address/view/address_view.dart';
import '../modules/payment/binding/payment_binding.dart';
import '../modules/payment/view/payment_view.dart';
import '../modules/payment_success/bindings/payment_success_binding.dart';
import '../modules/payment_success/view/payment_success_view.dart';
import '../modules/profile/binding/profile_binding.dart';
import '../modules/profile/view/profile_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/view/privacy_policy_view.dart';
import '../modules/settings/binding/settings_binding.dart';
import '../modules/settings/view/settings_view.dart';
import '../modules/support/binding/support_binding.dart';
import '../modules/support/view/support_view.dart';
import 'import.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._internal();

  static final AppPages _instance = AppPages._internal();

  factory AppPages() {
    return _instance;
  }

  final routes = [
    GetPage(
      name: AppRoutes().app,
      page: () => const App(),
      binding: AppBinding(),
    ),

    GetPage(
      name: AppRoutes().login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes().setPin,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes().loginWithPin,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes().dbExample,
      page: () => const App(),
      binding: AppBinding(),
    ),

    // E-Commerce Routes
    GetPage(
      name: AppRoutes().splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes().onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes().signup,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes().forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes().home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes().profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes().productListing,
      page: () => const ProductListingView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes().productDetails,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes().reviews,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes().cart,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes().checkout,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: AppRoutes().coupons,
      page: () => const CouponView(),
      binding: CouponBinding(),
    ),
    GetPage(
      name: AppRoutes().orders,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutes().orderDetails,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes().wishlist,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: AppRoutes().notifications,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes().address,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: AppRoutes().addNewAddress,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: AppRoutes().editAddress,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: AppRoutes().payment,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: AppRoutes().paymentSuccess,
      page: () => const PaymentSuccessView(),
      binding: PaymentSuccessBinding(),
    ),
    GetPage(
      name: AppRoutes().privacy,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: AppRoutes().referAndEarn,
      page: () => const InviteFriendsView(),
      binding: InviteFriendsBinding(),
    ),
    GetPage(
      name: AppRoutes().settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes().changePassword,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: AppRoutes().support,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: AppRoutes().categories,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: AppRoutes().subcategories,
      page: () => const SubCategoriesView(),
      binding: SubCategoriesBinding(),
    ),
    GetPage(
      name: AppRoutes().orderConfirmation,
      page: () => const OrderConfirmationView(),
      binding: OrderConfirmationBinding(),
    ),
    GetPage(
      name: AppRoutes().orderTracking,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes().returns,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutes().chat,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: AppRoutes().help,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: AppRoutes().loyaltyPoints,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes().recentlyViewed,
      page: () => const ProductListingView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes().about,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes().terms,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: AppRoutes().contact,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: AppRoutes().search,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
  ];
}
