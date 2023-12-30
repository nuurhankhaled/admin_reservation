import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';

class SummaryCard extends StatelessWidget {
  String? textName;
  String? textTotalNumber;
  dynamic icon;
  dynamic containerColor;

  SummaryCard(
      {this.icon, this.containerColor, this.textName, this.textTotalNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () => context.pushNamed(Routes.viewScreen),
        child: Container(
          alignment: AlignmentDirectional.centerStart,
          width: 319.w,
          height: 270.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.sp),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, spreadRadius: -1, blurRadius: 5)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 50.sp,
                      ),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Text('$textName'),
                SizedBox(
                  height: 20.h,
                ),
                Text('$textTotalNumber'),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
