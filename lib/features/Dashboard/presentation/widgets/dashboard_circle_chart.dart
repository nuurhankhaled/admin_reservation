import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import '../../../../Core/Api/endPoints.dart';
import '../../../../core/Api/my_http.dart';
import '../../../../core/theming/colors.dart';
import '../../../View-Waiting-Reservations/data/models/reservations-model.dart';
import 'charts_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircleChart extends StatelessWidget {
  get chartData => null;
  String head ;
  double percent ;
  CircleChart({required this.head, required this.percent});

  @override
  Widget build(BuildContext context) {
    return ChartsConatiner(
      chartWidget: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text(head),
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
                    borderRadius: BorderRadius.circular(60.sp)
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            CircularPercentIndicator(
              radius: 130.0.sp,
              lineWidth: 25.0.w,
              percent: (percent) ,
              center: new Text("${percent*100}%"),
              progressColor: AppColors.primaryColor,
              animateFromLastPercent: true,
              animation: true,
              animationDuration: 1200,
              circularStrokeCap: CircularStrokeCap.round,
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
