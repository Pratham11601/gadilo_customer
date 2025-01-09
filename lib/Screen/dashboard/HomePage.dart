import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/Screen/Profile.dart';
import 'package:gadi_customer_repo/Screen/dashboard/SparePandA.dart';
import 'package:gadi_customer_repo/Screen/dashboard/bike_screen.dart';
import 'package:gadi_customer_repo/Screen/dashboard/cars_screen.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../utils/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  DashBoardController dashBoardController = Get.find();
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: dashBoardController.selectedIndex.value,
          children: [
            // Home screen
            CarsScreen(),
            BikeScreen(),
            SparePandA(),
            Profile(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return SalomonBottomBar(
          currentIndex: dashBoardController.selectedIndex.value,
          selectedColorOpacity: 1,
          selectedItemColor: Colors.white,
          onTap: (index) {
            dashBoardController.selectedIndex.value = index;
          },
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: ColorsForApp.primaryColor,
            ),

            /// Bike
            SalomonBottomBarItem(
              icon: Image.asset(
                'assets/iyrd.png',
                width: 20,
                height: 20,
              ),
              activeIcon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'assets/iyrd.png',
                  width: 20,
                  height: 20,
                ),
              ),
              title: Text(
                "Bike",
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: ColorsForApp.primaryColor,
            ),

            /// Spare Parts & Accessories
            SalomonBottomBarItem(
              icon: Image.asset(
                'assets/tfddx.png',
                width: 20,
                height: 20,
              ),
              activeIcon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'assets/tfddx.png',
                  width: 20,
                  height: 20,
                ),
              ),
              title: Text(
                "Spare Parts",
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: ColorsForApp.primaryColor,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Image.asset(
                'assets/yugrx.png',
                width: 20,
                height: 20,
              ),
              activeIcon: Icon(Icons.person_3_rounded, color: Colors.white),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: ColorsForApp.primaryColor,
            ),
          ],
        );
      }),
    );
  }
}
