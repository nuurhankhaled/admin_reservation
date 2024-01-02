import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import 'charts_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircleChart extends StatelessWidget {
  const CircleChart({Key? key}) : super(key: key);

  get chartData => null;

  @override
  Widget build(BuildContext context) {
    return ChartsConatiner(
      chartWidget: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text('اسم '),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
              ),
              child: Container(
                width: double.infinity,
                height: 2.3.sp,
                decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(60.sp)),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            InkWell(
              onTap: () => context.pushNamed(Routes.viewPersonScreen),
              child: CircularPercentIndicator(
                radius: 130.0.sp,
                lineWidth: 25.0.w,
                percent: 0.5,
                center: new Text("50%"),
                progressColor: AppColors.primaryColor,
                animateFromLastPercent: true,
                animation: true,
                animationDuration: 1200,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
