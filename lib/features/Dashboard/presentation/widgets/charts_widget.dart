import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartsConatiner extends StatelessWidget {
  Widget? chartWidget;
   ChartsConatiner({Key? key, this.chartWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        width: 648.w,
        height: 450.h,
        decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.sp),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, spreadRadius: -1, blurRadius: 5)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child:chartWidget ,
        ),
      ),
    );
  }
}
