import 'package:get/get.dart';

import '../controller/app_controller.dart';
import '../controller/dashboard_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController());
    Get.lazyPut(() => DashBoardController());
  }
}
