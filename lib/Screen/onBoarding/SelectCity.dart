import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class itemModel {
  late String imgUrl;
  late String textData;
  itemModel(this.imgUrl, this.textData);
}

class Item {
  final String imgUrl;
  final String title;
  Item(
    this.imgUrl,
    this.title,
  );
}

class SelectCity extends StatefulWidget {
  SelectCity({super.key});
  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final List<Color> buttonColors = List.generate(10, (index) => Colors.blue);
  final List<bool> buttonPressed = List.generate(10, (index) => false);
  int? activeIndex;

  // final dashController dashController = Get.find();
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
          SizedBox(height: 20),
          SizedBox(
            height: 45,
            width: 316,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
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
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.3, right: 10),
                      child: TextField(
                        controller: dashController.locationText.value,
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(91, 91, 91, 1),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: InkWell(
                            onTap: () {
                              dashController.saveLocation(dashController.locationText.value.text);
                            },
                            child: Container(
                              width: 43,
                              height: 34,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(10, 98, 148, 1),
                                borderRadius: BorderRadius.circular(23),
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 0.5),
                                    Image.asset(
                                      "assets/wdeded.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 40),
              Image.asset(
                "assets/ggb.png",
                width: 14,
                height: 14,
              ),
              SizedBox(width: 0),
              Text(
                "Use Current Location",
                style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(32, 129, 239, 1), fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 30),
              Text(
                "Popular Cities",
                style: GoogleFonts.poppins(fontSize: 14, color: Color.fromRGBO(6, 10, 14, 0.62), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3.0,
                childAspectRatio: 0.9,
              ),
              itemCount: dashController.itemList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    dashController.saveLocation(dashController.itemList[index].title);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Stack(children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                dashController.itemList[index].imgUrl,
                                height: 101,
                                width: 111,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    dashController.itemList[index].title,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(15, 15, 20, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Other Cities",
                style: GoogleFonts.poppins(fontSize: 14, color: Color.fromRGBO(99, 102, 106, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Container(
            height: 180,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: dashController.cities.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    dashController.saveLocation(dashController.cities[index].name);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Image.asset(
                          "assets/ujh.png",
                          width: 14,
                          height: 14,
                        ),
                        SizedBox(width: 10),
                        Text(
                          dashController.cities[index].name, // Use the enum name
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(0),
            child: ElevatedButton(
              onPressed: () => Get.toNamed(Routes.HOME_SCREEN),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29),
                ),
                minimumSize: Size(308, 40),
                backgroundColor: Color.fromRGBO(10, 98, 148, 1),
                elevation: 0,
              ),
              child: Text(
                "Next",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(251, 254, 255, 1),
                ),
              ),
            ),
          ),
        ],
      )))),
    );
  }
}
