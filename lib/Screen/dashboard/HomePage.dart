import 'package:flutter/material.dart';
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
              label: "Spare Parts and accersories",
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

            /// Profile
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
        ;
      }),
    );
  }
}
