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
    return
        // Container(
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Theme(
        //       data: Theme.of(context).copyWith(
        //         dividerColor: Colors.transparent,
        //       ),
        //       child: ExpansionTile(
        //         showTrailingIcon: false,
        //         title: Row(
        //           crossAxisAlignment: CrossAxisAlignment.end,
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1.h),
      height: 5.h,
      width: 27.w,
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
            width: 18,
            height: 18,
          ),
          width(2.5.w),
          Text(
            "Filter   ",
            style: TextStyle(fontSize: 15.px, fontWeight: FontWeight.bold),
          ),
          width(1.w),
        ],
      ),
    );
    //             ],
    //           ),
    //           children: [
    //             Container(
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(10),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Color.fromRGBO(0, 0, 0, 0.13),
    //                     spreadRadius: 0.1,
    //                     offset: Offset(0, 1),
    //                   ),
    //                 ],
    //               ),
    //               child: Row(
    //                 children: [
    //                   width(27.w),
    //                   Container(
    //                     width: 70.w,
    //                     child: FilterDialogStyle(
    //                       onApplyFilters: () {
    //                         // Optionally hide after applying filters
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
