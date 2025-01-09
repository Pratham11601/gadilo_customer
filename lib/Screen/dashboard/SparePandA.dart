import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/Screen/dashboard/S&ADetails.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
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
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        debugPrint("Hello");
                        await dashBoardController.getCarsListApi();
                      },
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
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: 43,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(10, 98, 148, 1),
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Image.asset(
                                    "assets/wdeded.png",
                                    width: 30,
                                    height: 30,
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
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Obx(() {
            if (dashBoardController.isLoading.value) {
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
            if (dashBoardController.getCarsList.isEmpty) {
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
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 1.w,
                  mainAxisSpacing: 5.h,
                ),
                physics: const NeverScrollableScrollPhysics(),
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
              );
            }
          })
        ],
      )))),
    );
  }
}
