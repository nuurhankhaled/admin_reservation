import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
      width: double.maxFinite,
      height: 1.h,
      color: AppColors.greyColor.withOpacity(0.3),
    );
  }
}
