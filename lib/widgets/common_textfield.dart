import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/text_style.dart';

class CommonTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final Color? color;
  final void Function()? onTap;
  final InputDecoration? decoration;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;
  final TextStyle? style;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? counterText;
  final InputBorder? border;
  final int? maxLines;
  final bool? read;
  final TextStyle? errorStyle;
  final void Function(String)? onChanged;

  const CommonTextField({
    Key? key,
    this.height,
    this.width,
    this.controller,
    this.color,
    this.onTap,
    this.decoration,
    this.read,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.style,
    this.maxLength,
    this.keyboardType,
    this.counterText,
    this.border,
    this.maxLines,
    this.errorStyle,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        readOnly: read ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ??
              TextHelper.size16(context).copyWith(
                color: ColorsForApp.colorBlackShade,
                fontWeight: FontWeight.w400,
              ),
          labelText: labelText,
          labelStyle: labelStyle,
          prefixIcon: prefixIcon,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorsForApp.colorBlackShade),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorsForApp.colorBlackShade),
          ),
        ),
        style: style ??
            TextHelper.size16(context).copyWith(
              color: ColorsForApp.colorBlackShade,
              fontWeight: FontWeight.w400,
            ),
        keyboardType: keyboardType ?? TextInputType.text,
        maxLength: maxLength,
        maxLines: maxLines,
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
