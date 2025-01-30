import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/Screen/dashboard/S&ADetails.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/Common_dialog.dart';
import '../../widgets/clear_filter_button.dart';
import '../../widgets/common_filter_container.dart';
import '../../widgets/common_spare_item.dart';
import '../../widgets/constant_widgets.dart';

class SparePandA extends StatelessWidget {
  final DashBoardController dashBoardController = Get.find();

  SparePandA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: AppBar(backgroundColor: Colors.white, elevation: 0, automaticallyImplyLeading: false, flexibleSpace: const Text("")),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(
            height: 42,
            width: 361,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ]),
                  width: 91.w,
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search Cities",
                      filled: true,
                      fillColor: Colors.white, // Background color
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        dashBoardController.fetchCities(value);
                      } else {
                        dashBoardController.fetchCities("");
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.3, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(91, 91, 91, 1),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() {
                return Visibility(
                    visible: dashBoardController.isSparesFilterApplied.value,
                    child: GestureDetector(
                        onTap: () {
                          dashBoardController.VehicleType.value = "";
                          dashBoardController.filterOwners.value = "";
                          dashBoardController.spareType.value = "";
                          dashBoardController.isSparesFilterApplied.toggle();
                          dashBoardController.getSpaeresListApi();
                        },
                        child: CustomClearFilterButton()));
              }),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterDialogForSpares(
                        onApplyFilters: () {
                          dashBoardController.isSparesFilterApplied.value = true;
                          dashBoardController.getSparedList.clear();
                          dashBoardController.getSpaeresListApi();
                        },
                      );
                    },
                  );
                },
                child: FilterContainer(),
              ),
            ],
          ),
          Obx(() {
            if (dashBoardController.isLoadingInSpares.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  height(12.h),
                  Center(
                    child: CupertinoActivityIndicator(
                      radius: 30,
                      color: ColorsForApp.primaryColor,
                    ),
                  ),
                  Text(
                    'Loading',
                    style: TextHelper.size16(context).copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            if (dashBoardController.getSparedList.isEmpty) {
              return Column(
                children: [
                  height(32.h),
                  Text(
                    'There are no Spares available',
                    style: TextHelper.size18(context).copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else {
              return SizedBox(
                height: 75.h,
                width: 99.w,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 1.w,
                    mainAxisSpacing: 5.h,
                  ),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(1.w),
                  itemCount: dashBoardController.getSparedList.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        final spares = dashBoardController.getSparedList[index];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SandADetails(spares: spares)));
                      },
                      child: spareItem(
                        spares: dashBoardController.getSparedList[index],
                      )),
                ),
              );
            }
          })
        ],
      )))),
    );
  }
}
