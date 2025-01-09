import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/controller/setting_controller.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
    Get.put<AuthController>(AuthController());
    Get.put<DashBoardController>(DashBoardController());
    Get.put<SettingController>(SettingController());
  }
}
