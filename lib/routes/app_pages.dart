import 'package:gadi_customer_repo/Screen/dashboard/HomePage.dart';
import 'package:gadi_customer_repo/Screen/dashboard/bike_deals.dart';
import 'package:gadi_customer_repo/Screen/onBoarding/Login.dart';
import 'package:gadi_customer_repo/Screen/onBoarding/Password.dart';
import 'package:gadi_customer_repo/Screen/onBoarding/Register.dart';
import 'package:gadi_customer_repo/Screen/onBoarding/ResetPassword.dart';
import 'package:gadi_customer_repo/Screen/onBoarding/SelectCity.dart';
import 'package:gadi_customer_repo/Screen/onBoarding/VerifyMobNo.dart';
import 'package:gadi_customer_repo/Screen/setting/AboutUs.dart';
import 'package:gadi_customer_repo/Screen/setting/Support&F.dart';
import 'package:gadi_customer_repo/binding/dashboard_binding.dart';
import 'package:gadi_customer_repo/binding/setting_binding.dart';
import 'package:get/get.dart';

import '../Screen/AddAddress.dart';
import '../Screen/SplashScreen.dart';
import '../Screen/dashboard/cars_deal.dart';
import '../Screen/onBoarding/OTP.dart';
import '../Screen/onBoarding/PrivacyPolicy.dart';
import '../Screen/onBoarding/terms_of_use.dart';
import '../Screen/setting/MyProfile.dart';
import '../binding/auth_binding.dart';
import '../routes/routes.dart';

class AppPages {
  AppPages._();

  static const Transition transition = Transition.native;
  static const String initialRoute = Routes.SPLASH_SCREEN;

  // Routes
  static final route = [
    // OnBoarding
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => SplashScreen(),
      transition: transition,
    ),

    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => Login(),
      binding: AuthBinding(),
    ),

    GetPage(name: Routes.OTP_SCREEN, page: () => OTP(), binding: AuthBinding(), transition: Transition.leftToRight),

    GetPage(name: Routes.SELECT_CITY_SCREEN, page: () => SelectCity(), binding: DashboardBinding(), transition: Transition.zoom),

    GetPage(
      name: Routes.Register_SCREEN,
      page: () => Register(),
      binding: AuthBinding(),
    ),

    // password
    GetPage(name: Routes.RESET_PASSWORD_SCREEN, page: () => ResetPassword(), binding: AuthBinding(), transition: Transition.rightToLeft),

    GetPage(
      name: Routes.RESET_PASSWORD_SCREEN,
      page: () => ResetPassword(),
      binding: AuthBinding(),
    ),
    GetPage(name: Routes.PRIVACY_POLICY_SCREEN, page: () => PrivacyPolicy(), binding: AuthBinding()),
    GetPage(name: Routes.TERMS_CONDN_SCREEN, page: () => Terms_ofUser(), binding: AuthBinding()),

    GetPage(name: Routes.VERIFY_MOB_SCREEN, page: () => VerifyMobNo(), binding: AuthBinding(), transition: Transition.zoom),

    // HOME
    GetPage(
      name: Routes.HOME_SCREEN,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    // GetPage(name: Routes.BIKE_DETAILS_SCREEN, page: () => BikeDetails(), binding: DashboardBinding(), transition: Transition.circularReveal),
    GetPage(name: Routes.CARS_DEAL_SCREEN, page: () => CarsDeal(), binding: DashboardBinding(), transition: Transition.circularReveal),
    GetPage(name: Routes.BIKE_DEAL_SCREEN, page: () => BikeDeal(), binding: DashboardBinding(), transition: Transition.downToUp),

    //Setting
    GetPage(name: Routes.PROFILE_SCREEN, page: () => MyProfile(), binding: SettingBinding(), transition: Transition.circularReveal),
    GetPage(name: Routes.CHANGE_PASSWORD_SCREEN, page: () => Password(), binding: SettingBinding(), transition: Transition.circularReveal),
    GetPage(name: Routes.SupportAndF_SCREEN, page: () => SupportAndF(), binding: SettingBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.ABOUT_US_SCREEN, page: () => AboutUs(), binding: SettingBinding(), transition: Transition.rightToLeftWithFade),
    GetPage(name: Routes.ADD_ADDRESS_SCREEN, page: () => AddAddress(), binding: SettingBinding(), transition: Transition.circularReveal),
  ];
}
