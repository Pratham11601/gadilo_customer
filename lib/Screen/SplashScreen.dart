import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:get/get.dart';

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
    //todo for creating main ui here
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
      body: Center(child: Image.asset('assets/iiu.gif').animate().fadeIn()),
    );
  }
}
