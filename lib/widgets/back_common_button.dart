import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonBackButton extends StatelessWidget {
  CommonBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Row(
        children: [
          SizedBox(width: 10),
          Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromRGBO(15, 15, 20, 0.32),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(27),
            ),
            child: Center(
              child: Image.asset(
                'assets/fgjk.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
