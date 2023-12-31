import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewPersonScreen extends StatelessWidget {
  const ViewPersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('View Person'),
            leading: Padding(
              padding: EdgeInsets.only(right: 50.w),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => context.pop(),
              ),
            )),
        body: SingleChildScrollView());
  }
}
