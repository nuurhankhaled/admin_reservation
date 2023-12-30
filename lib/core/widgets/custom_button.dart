
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import 'custom_texts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final BorderSide? borderSide;
  final double? elevation;
  final bool? enableShadow;
  final bool? isEnabled;
  final List<Color>? gradientColors;

  final List<BoxShadow>? boxShadow;
  const CustomButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.color,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.width,
      this.height,
      this.margin,
      this.padding,
      this.borderRadius = 8.0,
      this.borderSide,
      this.elevation,
      this.enableShadow,
      this.isEnabled,
      this.boxShadow,
      this.gradientColors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        height: height ?? 60,
        margin: margin,
        decoration: BoxDecoration(
          gradient: gradientColors != null
              ? LinearGradient(
                  colors: gradientColors!,
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter)
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderSide?.color ?? Colors.transparent),
          color: color ?? AppColors.buttonBackGroundColor,
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: -1,
                  blurRadius: 5.sp,
                ),
              ],
        ),
        child: Center(
          child: Text20(
            text: text,
            textColor: textColor ?? Colors.white,
            size: fontSize,
          ),
        ),
      ),
    );
  }
}
