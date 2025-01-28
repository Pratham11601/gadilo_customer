import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../api/api_manager.dart';
import '../routes/routes.dart';
import '../utils/app_enums.dart';
import '../utils/connection.dart';
import '../utils/jwt_config.dart';
import '../utils/storage_config.dart';

class AppController extends GetxController {
  final Connection connection = Connection();
  StreamSubscription<bool>? connectionSubscription;
  dynamic userId;

  @override
  void onInit() async {
    super.onInit();

    APIManager.init(this);

    // Fetch token
    userId = await JwtConfig.fetchLocalUserToken();

    dynamic isExistingUser = await LocalStorage.fetchValue(StorageKey.userid);

    // Initialize network service

    await initializeConnectionServices();

    debugPrint('Token ===========> ${userId.toString()}');

    // Initialize api manager

    Future.delayed(Duration(seconds: 4), () {
      if (userId != null) {
        debugPrint("isExistingUser ------->   ${isExistingUser}   ");

        if (isExistingUser != null) {
          Get.offAllNamed(Routes.HOME_SCREEN);
        } else {
          Get.offAllNamed(Routes.LOGIN_SCREEN);
        }
      } else {
        Get.offAllNamed(Routes.LOGIN_SCREEN);
      }
    });
  }

  @override
  void onClose() {
    connectionSubscription?.cancel();
    super.onClose();
  }

  void updateToken(String? token) {
    userId = token;
    JwtConfig.storeUserToken(token);
  }

  /// Connection
  Future<void> initializeConnectionServices() async {
    connection.initValue = await Connection.checkInternet();
    connectionSubscription = connection.onChangeConnectivity.listen((event) {
      debugPrint('Has internet $event');
    });
  }
}
