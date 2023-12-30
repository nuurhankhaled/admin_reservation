import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable

class Text8 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  TextDecoration? decoration;
  Color? decorationColor;
  double? decorationThickness;

  Text8({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 8.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),

      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}


class Text10 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  TextDecoration? decoration;
  Color? decorationColor;
  double? decorationThickness;

  Text10({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 10.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),

      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}


class Text12 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  TextDecoration? decoration;
  Color? decorationColor;
  double? decorationThickness;

  Text12({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 12.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),

      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}


class Text14 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  TextDecoration? decoration;
  Color? decorationColor;
  double? decorationThickness;

  Text14({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 14.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? ( MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),

      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text15 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  TextDecoration? decoration;
  Color? decorationColor;
  double? decorationThickness;

  Text15({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 15.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),

      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text16 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text16({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(softWrap: true,
      text,
      style: TextStyle(
        fontSize: size ?? 16.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}


class Text17 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text17({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(softWrap: true,
      text,
      style: TextStyle(
        fontSize: size ?? 17.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text18 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text18({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 18.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text20 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text20({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 20.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text22 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text22({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 22.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text24 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text24({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 24.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text26 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text26({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 26.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text28 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text28({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 28.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Poppins',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}
