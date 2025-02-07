import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'constant_widgets.dart';

class FilterContainer extends StatefulWidget {
  @override
  _FilterContainerState createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0.h),
      height: 4.h,
      width: 22.w,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            spreadRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          width(2.5.w),
          Image.asset(
            'assets/fds.png',
            width: 16,
            height: 16,
          ),
          width(2.w),
          Text(
            "Filter   ",
            style: TextStyle(fontSize: 12.px, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
