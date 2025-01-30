import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/constant_widgets.dart';

class SelectCity extends StatefulWidget {
  SelectCity({super.key});
  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final List<Color> buttonColors = List.generate(10, (index) => Colors.blue);
  final List<bool> buttonPressed = List.generate(10, (index) => false);
  int? activeIndex;

  final DashBoardController dashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: AppBar(backgroundColor: Colors.white, elevation: 0, automaticallyImplyLeading: false, flexibleSpace: Text("")),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(1, 1),
              ),
            ]),
            width: 91.w,
            child: TextField(
              style: TextStyle(fontSize: 16),
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
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  dashController.fetchCities(value);
                } else {
                  dashController.getDefaultCities();
                }
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Image.asset(
                "assets/ggb.png",
                width: 17,
                height: 17,
              ),
              width(3),
              GestureDetector(
                onTap: () {
                  dashController.fetchCurrentLocation();
                },
                child: Obx(() {
                  return dashController.isloadingLocation.value
                      ? Text(
                          " Fetching location........! ",
                          style: GoogleFonts.poppins(
                            fontSize: 17.sp,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w400,
                          ),
                        ) // Centered loader
                      : Text(
                          dashController.cityName.value,
                          style: GoogleFonts.poppins(
                            fontSize: 17.sp,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                }),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 18),
              Text(
                "Popular Cities",
                style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(6, 10, 14, 0.62), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 170,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3.0,
                  childAspectRatio: 0.9,
                ),
                itemCount: dashController.cityListModel.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      dashController.saveLocation(dashController.cityListModel[index].cityName!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: dashController.cityListModel[index].cityImg != null &&
                                          dashController.cityListModel[index].cityImg!.isNotEmpty
                                      ? Image.network(
                                          dashController.cityListModel[index].cityImg!,
                                          height: 28.w,
                                          width: 28.w,
                                          fit: BoxFit.fill,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Icon(Icons.broken_image, size: 28.w, color: ColorsForApp.primaryColor);
                                          },
                                        )
                                      : Icon(Icons.image_not_supported, size: 26.w, color: ColorsForApp.primaryColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    dashController.cityListModel[index].cityName ?? "Unknown",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(15, 15, 20, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          SizedBox(height: 20),
          // f
        ],
      )))),
    );
  }
}
