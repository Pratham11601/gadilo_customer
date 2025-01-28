import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/utils/app_colors.dart';
import 'package:gadi_customer_repo/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/auth/brandModel.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            await dashboardController.getCarsListApi();
          },
          child: Column(
            children: [
              height(3.h),
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
              height(2.h),
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
                              dashboardController.getCarsByBrandList.clear();
                              dashboardController.getCarsDealsListApi();
                              Get.toNamed(Routes.CARS_DEAL_SCREEN);
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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

                        if (dashboardController.getCarsList.isEmpty) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              height(19.h),
                              Text(
                                'Opps ! No Cars Found ',
                                style: TextHelper.size16(context).copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        } else {
                          return SizedBox(
                            height: 32.h,
                            width: 95.w,
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
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
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ],
              ),
              height(1.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
          child: Image.network(
            'https://gadilobharat.com/assets/images/c.jpg',
            width: 361,
            height: 205,
            fit: BoxFit.cover,
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
                    Expanded(
                        child: TypeAheadField<BrandNamesList>(
                      controller: dashboardController.searchText.value,
                      decorationBuilder: (context, child) => Material(
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(color: Colors.transparent), // Ensure no border
                          ),
                          child: child,
                        ),
                      ),
                      suggestionsCallback: (query) async {
                        await dashboardController.fetchBrands(query);
                        return dashboardController.brand;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.brandName ?? ""),
                        );
                      },
                      errorBuilder: (context, error) {
                        return Center(
                          child: Text("Error occurred!"),
                        );
                      },
                      onSelected: (BrandNamesList value) {
                        dashboardController.getCarsByBrandList.clear();
                        dashboardController.setFilterBrand(value.brandName!);
                        dashboardController.getCarsDealsListApi();
                        Get.toNamed(Routes.CARS_DEAL_SCREEN);

                        print(value.toString());
                        print(value.toJson());
                        print(value);
                        print(value);
                      },
                    )),
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
        dashboardController.getCarsByBrandList.clear();
        dashboardController.setFilterBrand(brandName);
        dashboardController.getCarsDealsListApi();
        Get.toNamed(Routes.CARS_DEAL_SCREEN);
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
      height: 83.h,
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
              dashboardController.isCarFilterApplied.value = true;
              String brandName = car.brand.toString().split('.').last;
              dashboardController.getCarsByBrandList.clear();
              dashboardController.setFilterBrand(brandName);
              dashboardController.getCarsDealsListApi();
              Get.toNamed(Routes.CARS_DEAL_SCREEN);
              dashboardController.isImageVisible.value == true ? true.obs : dashboardController.isImageVisible.toggle();
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
