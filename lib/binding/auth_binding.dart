import 'package:gadi_customer_repo/controller/app_controller.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController());
    Get.put<AuthController>(AuthController());
  }
}
