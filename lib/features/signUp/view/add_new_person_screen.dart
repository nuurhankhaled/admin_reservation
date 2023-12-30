import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_new_person_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewPersonScreen extends StatefulWidget {
  const AddNewPersonScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPersonScreen> createState() => _AddNewPersonScreenState();
}

class _AddNewPersonScreenState extends State<AddNewPersonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 15.w, right: 10.w, top: 8.h, bottom: 8.h),
                child: Container(
                  width: 75.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                        //color: AppColors.lightGrey,
                        width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30.w,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/signup.jpg',
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40.w,
                        child: Column(
                          children: [
                            //AddNewPersonWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
