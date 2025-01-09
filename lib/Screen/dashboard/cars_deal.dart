import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/dashboard_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/common_cards_cars.dart';
import '../../widgets/constant_widgets.dart';
import 'CarDetails.dart';

class CarsDeal extends StatelessWidget {
  final DashBoardController dashboardController = Get.find();
  CarsDeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Best Deal Cars",
          style: TextHelper.size20(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (dashboardController.isLoading.value) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              height(12.h),
              const Center(
                child: CupertinoActivityIndicator(
                  radius: 30,
                  color: ColorsForApp.primaryColor,
                ),
              ),
              Text(
                'Loading cars',
                style: TextHelper.size16(context).copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }

        if (dashboardController.getCarsDealsList.isEmpty) {
          return Column(
            children: [
              height(12.h),
              Text(
                'There are no Cars Available',
                style: TextHelper.size16(context).copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: dashboardController.getCarsDealsList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                final cars = dashboardController.getCarsDealsList[index];
                Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetails(cars: cars)));
              },
              child: buildCommonCarsCard(
                context,
                cars: dashboardController.getCarsDealsList[index],
              ),
            ),
          );
        }
      }),
    );
  }
}
