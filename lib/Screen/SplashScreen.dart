import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../widgets/constant_widgets.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  final DashBoardController authController = Get.put(DashBoardController());

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 4), () {
    //   Get.toNamed(Routes.LOGIN_SCREEN);
    //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 98, 148, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: AppBar(
          backgroundColor: Color.fromRGBO(10, 98, 148, 1),
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Center(
            child: Text(" "),
          ),
        ),
      ),
      body: Column(
        children: [
          height(21.h),
          Center(
              child: Image.asset(
            'assets/gadilo_bharat.png',
            width: 80.w,
            height: 80.w,
          )),
          height(21.h),
          Text(
            textAlign: TextAlign.center,
            "Welcome to GADILO!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
          Center(
            child: SizedBox(
              width: 77.w,
              child: Text(
                textAlign: TextAlign.center,
                "Dive into the world of cars, bikes & accessories.Your big find is just clicks away",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
