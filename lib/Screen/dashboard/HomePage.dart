import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gadi_customer_repo/Screen/Profile.dart';
import 'package:gadi_customer_repo/Screen/dashboard/SparePandA.dart';
import 'package:gadi_customer_repo/Screen/dashboard/bike_screen.dart';
import 'package:gadi_customer_repo/Screen/dashboard/cars_screen.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/utils/app_colors.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashBoardController dashBoardController = Get.find();
  DashboardScreen({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('Exit Application'),
            content: Text('Do you want to close the application?'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: Text('No'),
              ),
              CupertinoDialogAction(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: dashBoardController.selectedIndex.value,
            children: [
              CarsScreen(),
              BikeScreen(),
              SparePandA(),
              Profile(),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            currentIndex: dashBoardController.selectedIndex.value,
            selectedItemColor: ColorsForApp.primaryColor,
            selectedLabelStyle: TextStyle(color: ColorsForApp.primaryColor),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: (index) {
              dashBoardController.selectedIndex.value = index;
            },
            items: [
              /// Home
              BottomNavigationBarItem(
                label: "Car",
                icon: Icon(
                  Icons.directions_car,
                  size: 22,
                ),
              ),

              /// Bike
              BottomNavigationBarItem(
                label: "Bike",
                icon: Image.asset(
                  'assets/iyrd.png',
                  width: 20,
                  height: 20,
                ),
                activeIcon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    ColorsForApp.primaryColor,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/iyrd.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),

              /// Spare Parts & Accessories
              BottomNavigationBarItem(
                label: "Spare Parts and Accessories",
                icon: Image.asset(
                  'assets/tfddx.png',
                  width: 20,
                  height: 20,
                ),
                activeIcon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    ColorsForApp.primaryColor,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/tfddx.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),

              BottomNavigationBarItem(
                label: "Profile",
                icon: Image.asset(
                  'assets/yugrx.png',
                  width: 20,
                  height: 20,
                ),
                activeIcon: Icon(Icons.person_3_rounded, color: ColorsForApp.primaryColor),
              ),
            ],
          );
        }),
      ),
    );
  }
}
