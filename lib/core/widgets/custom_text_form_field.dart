import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool? obscureText;
  final bool? autofocus;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final bool? readOnly;
  final bool? showCursor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;

  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final FormFieldSetter<String>? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enabled;
  final autofillHints;
  final EdgeInsets? contentPadding;
  final EdgeInsets? padding;
  final bool? expands;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? height;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.padding,
    this.textStyle,
    this.hintStyle,
    this.hintText,
    this.labelText,
    this.backgroundColor,
    this.helperText,
    this.borderColor,
    this.borderWidth,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.borderRadius,
    this.onSaved,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled,
    this.autofillHints,
    this.contentPadding,
    this.expands,
    this.maxLines,
    this.minLines,
    this.onFieldSubmitted,
    this.buildCounter,
    this.scrollPhysics,
    this.onTap,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.h,
      padding: padding,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? Colors.grey[200]!,
            width: borderWidth ?? 1.sp,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(10.sp),
          color: backgroundColor ?? Colors.grey[200]!),
      child: Center(
        child: TextFormField(
          style: textStyle,
          autofillHints: autofillHints,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          controller: controller,
          obscureText: obscureText!,
          autofocus: autofocus!,
          autocorrect: autocorrect!,
          enableSuggestions: enableSuggestions!,
          readOnly: readOnly!,
          showCursor: showCursor,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          validator: validator,
          onSaved: onSaved,
          inputFormatters: inputFormatters,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
            labelText: labelText,
            hintStyle: hintStyle,
            hintText: hintText,
            helperText: helperText,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabled: enabled ?? true,
            contentPadding: contentPadding,
          ),
          expands: expands ?? false,
          maxLines: maxLines ?? 1,
          minLines: minLines,
          onFieldSubmitted: onFieldSubmitted,
          scrollPhysics: scrollPhysics,
          onTap: onTap,
        ),
      ),
    );
  }
}
