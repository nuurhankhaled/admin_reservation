import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewFeatureScreen extends StatelessWidget {
  const ViewFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("reservationApp".tr()),
          leading: Padding(
            padding: EdgeInsets.only(right: 50.w),
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 8.h,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.pushNamed('/viewFacility');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.blueGrey,
                ),
                child: Center(
                  child: Text(
                    "View ${index + 1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
