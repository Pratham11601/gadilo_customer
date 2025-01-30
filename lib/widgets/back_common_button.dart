import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonBackButton extends StatelessWidget {
  final Function? onBack;
  CommonBackButton({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
        if (onBack != null) {
          onBack!();
        } else {
          Get.back();
        }
      },
      child: Row(
        children: [
          SizedBox(width: 10),
          Container(
            width: 45,
            height: 35,
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
