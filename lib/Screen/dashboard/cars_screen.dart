import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/utils/app_colors.dart';
import 'package:gadi_customer_repo/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/dasboard/view_cars_model.dart';
import '../../routes/routes.dart';
import '../../utils/text_styles.dart';
import '../../widgets/Common_dialog.dart';
import '../../widgets/clear_filter_button.dart';
import '../../widgets/common_cards_cars.dart';
import '../../widgets/common_filter_container.dart';
import '../../widgets/constant_widgets.dart';
import 'CarDetails.dart';

class CarsScreen extends StatelessWidget {
  final DashBoardController dashboardController = Get.find();
  final AuthController authController = Get.find();

  CarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () async {
              await dashboardController.getCarsListApi();
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return Text(" Hey ${capitalizeFirstLetter(dashboardController.UserName.value)}!",
                          style: TextHelper.size18(context)
                              .copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold));
                    }),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.SELECT_CITY_SCREEN);
                      },
                      child: Row(
                        children: [
                          Obx(() {
                            return Text(
                              dashboardController.location.value,
                              style: TextHelper.size18(context),
                            );
                          }),
                          Image.asset(
                            'assets/juhf.png',
                            width: 24,
                            height: 24,
                          ),
                          width(3.w)
                        ],
                      ),
                    ),
                  ],
                ),
                _buildHeader(),
                height(5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      return Visibility(
                          visible: dashboardController.isCarFilterApplied.value,
                          child: GestureDetector(
                              onTap: () {
                                dashboardController.filterBrand.value = "";
                                dashboardController.filterColor.value = "";
                                dashboardController.filterBudget.value = "";
                                dashboardController.filterColor.value = "";

                                dashboardController.isCarFilterApplied.toggle();
                                dashboardController.getCarsListApi();
                              },
                              child: CustomClearFilterButton()));
                    }),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FilterDialog(
                              onApplyFilters: () {
                                dashboardController.isCarFilterApplied.value = true;
                                dashboardController.getCarsListApi();
                              },
                            );
                          },
                        );
                      },
                      child: FilterContainer(),
                    ),
                  ],
                ),
                _buildBrandRow(),
                Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: dashboardController.isImageVisible.value,
                        child: Row(
                          children: [
                            const SizedBox(width: 125),
                            GestureDetector(
                              onTap: () {
                                dashboardController.isImageVisible.toggle();
                              },
                              child: Text(
                                "View all brands",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(0, 90, 192, 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Image.asset(
                              'assets/iuhg.png',
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                      if (dashboardController.isImageVisible.value == false) _buildCarGridView(dashboardController.cars),
                    ],
                  );
                }),
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

                  if (dashboardController.getCarsList.isEmpty) {
                    return Column(
                      children: [
                        height(12.h),
                        Text(
                          '',
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
                      itemCount: dashboardController.getCarsList.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          dashboardController.getCarsListSuggestionApi();
                          final cars = dashboardController.getCarsList[index];
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetails(cars: cars)));
                        },
                        child: buildCommonCarsCard(
                          context,
                          cars: dashboardController.getCarsList[index],
                        ),
                      ),
                    );
                  }
                }),
                height(1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'assets/cdcoih.png',
          width: 361,
          height: 205,
        ),
        Positioned(
          top: 30,
          left: 86,
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/kjhg.png',
                    width: 26,
                    height: 26,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Best Value Deals',
                    style: TextStyle(
                      color: Color.fromRGBO(15, 15, 20, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Affordable prices on top brands.',
                    style: TextStyle(
                      color: Color.fromRGBO(15, 15, 20, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 90,
          left: 110,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.CARS_DEAL_SCREEN);
                dashboardController.getCarsDealsListApi();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29),
                ),
                minimumSize: const Size(116, 36),
                backgroundColor: const Color.fromRGBO(10, 98, 148, 1),
                elevation: 0,
              ),
              child: Text(
                "Find a Deal",
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: const Color.fromRGBO(251, 254, 255, 1)),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -24,
          left: 7,
          child: SizedBox(
            height: 52,
            width: 350,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(111, 111, 111, 0.13),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Image.asset(
                            "assets/rcr.png",
                            width: 5.w,
                            height: 5.w,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.3, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search by Brand/Model",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(91, 91, 91, 1),
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            suffixIcon: InkWell(
                              onTap: () {
                                dashboardController.getCarsListSearchApi();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Container(
                                  width: 15.w,
                                  height: 15.h,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(10, 98, 148, 1),
                                    borderRadius: BorderRadius.circular(70),
                                  ),
                                  child: Image.asset(
                                    "assets/wdeded.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandRow() {
    return Column(
      children: [
        Text(
          "Explore by brands",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
        ),
        height(2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBrandContainer('assets/zxcv.png', "Maruti Suzuki"),
            _buildBrandContainer('assets/sdfgh.png', "Toyota"),
            _buildBrandContainer('assets/iuyhgf.png', "Honda"),
          ],
        ),
      ],
    );
  }

  Widget _buildBrandContainer(String assetPath, String brandName) {
    return GestureDetector(
      onTap: () {
        dashboardController.getCarsList.clear();

        dashboardController.setFilterBrand(brandName);
        dashboardController.getCarsListApi();
        dashboardController.isImageVisible.value == true ? true.obs : dashboardController.isImageVisible.toggle();
      },
      child: Container(
        height: 13.h,
        width: 31.w,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          border: Border.all(
            color: const Color.fromRGBO(244, 244, 244, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            const SizedBox(height: 11),
            Image.asset(
              assetPath,
              width: 46,
              height: 46,
            ),
            const SizedBox(height: 5),
            Text(
              brandName,
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarGridView(List<VehicleBrandsModel> cars) {
    return SizedBox(
      height: 77.h,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1.w,
          mainAxisSpacing: 1.h,
        ),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return InkWell(
            onTap: () {
              String brandName = car.brand.toString().split('.').last;
              dashboardController.getCarsList.clear();
              dashboardController.setFilterBrand(brandName);
              dashboardController.isImageVisible.toggle();

              dashboardController.getCarsListApi();
            },
            child: Container(
              height: 40.h,
              width: 31.h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromRGBO(244, 244, 244, 1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    car.imagePath,
                    width: 46,
                    height: 46,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    car.brand.toString().split('.').last, // Get the enum name
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(15, 15, 20, 1),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
