import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/dashboard_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/common_bikes.dart';
import '../../widgets/constant_widgets.dart';
import 'BikeDetails.dart';

class BikeDeal extends StatelessWidget {
  final DashBoardController dashboardController = Get.find();
  BikeDeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Best Bike Deals",
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
              Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                  color: ColorsForApp.primaryColor,
                ),
              ),
              Text(
                'Loading Bikes..',
                style: TextHelper.size16(context).copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }

        if (dashboardController.getBikeDealList.isEmpty) {
          return Center(
            child: Text(
              'There are no Bike Available',
              style: TextHelper.size16(context).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 1.w, mainAxisSpacing: 1.h, mainAxisExtent: 30.h),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: dashboardController.getBikeDealList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                final bikes = dashboardController.getBikeDealList[index];
                Navigator.push(context, MaterialPageRoute(builder: (context) => BikeDetails(bikes: bikes)));
              },
              child: buildBikeWidget(
                context,
                bike: dashboardController.getBikeDealList[index],
              ),
            ),
          );
        }
      }),
    );
  }
}
