// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart'; // Assuming you are using the Sizer package for responsive sizing
//
// Widget filterScreen() {
//   Widget buildFilterSection(String title, List<Widget> options) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 "^", // Adds the ^ symbol
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 1.w),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 1.h),
//           Wrap(
//             spacing: 2.w,
//             runSpacing: 1.h,
//             children: options,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildOption(String label, {Color? color}) {
//     if (color != null) {
//       // For circular color options
//       return Container(
//         width: 8.w,
//         height: 8.w,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.grey),
//         ),
//       );
//     }
//     // For text options
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(fontSize: 10.sp),
//       ),
//     );
//   }
//
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Filter Screen'),
//       backgroundColor: Colors.teal,
//     ),
//     body: SingleChildScrollView(
//       child: Column(
//         children: [
//           buildFilterSection(
//             "By Number of Owner",
//             [
//               buildOption("First"),
//               buildOption("Second"),
//               buildOption("Third"),
//               buildOption("Fourth"),
//             ],
//           ),
//           buildFilterSection(
//             "By Budget",
//             [
//               buildOption("1L-5L"),
//               buildOption("5L-10L"),
//               buildOption("10L-15L"),
//               buildOption("30L+"),
//             ],
//           ),
//           buildFilterSection(
//             "By Colour",
//             [
//               buildOption("", color: Colors.black),
//               buildOption("", color: Colors.grey),
//               buildOption("", color: Colors.red),
//               buildOption("", color: Colors.blue),
//               buildOption("", color: const Color(0xFF2F4F2F)), // Dark green color
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
