import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/dashboard_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/back_common_button.dart';
import '../../widgets/common_cards_cars.dart';
import '../../widgets/constant_widgets.dart';
import 'CarDetails.dart';

class CarsDeal extends StatelessWidget {
  final DashBoardController dashboardController = Get.find();
  CarsDeal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: CommonBackButton(),
          title: Text(
            "${dashboardController.filterBrand.value}",
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
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

                if (dashboardController.getCarsByBrandList.isEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          height(42.h),
                          Text(
                            'There are no Cars Available',
                            style: TextHelper.size16(context).copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: dashboardController.getCarsByBrandList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        final cars = dashboardController.getCarsByBrandList[index];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetails(cars: cars)));
                      },
                      child: buildCommonCarsCard(
                        context,
                        cars: dashboardController.getCarsByBrandList[index],
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
