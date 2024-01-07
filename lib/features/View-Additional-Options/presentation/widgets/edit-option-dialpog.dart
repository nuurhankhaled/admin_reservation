import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/features/Add-Additional-Options/business-logic/additional_options_cubit/additional_options_cubit.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';

class EditAdditionalOptionsDialog extends StatelessWidget {
  EditAdditionalOptionsDialog(
      {super.key, required this.id, required this.name, required this.price});
  String id;
  String name;
  String price;
  late TextEditingController nameController = TextEditingController(text: name);

  late TextEditingController priceController =
      TextEditingController(text: price);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("id is $id");
    return BlocConsumer<AdditionalOptionsCubit, AdditionalOptionsState>(
      listener: (context, state) {
        if (state is EditAdditionalOptionsSuccess) {
          context.pop();
          context.pushReplacementNamed(Routes.viewAdditionalOptionsScreen);
        }
      },
      builder: (context, state) {
        var additionalOptionsCubit = AdditionalOptionsCubit.get(context);
        return Form(
          key: _formKey,
          child: PopScope(
            canPop: false,
            child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.symmetric(
                    horizontal: (MediaQuery.of(context).size.width != 766)
                        ? 650.w
                        : 500.w),
                child: Container(
                  width: double.infinity,
                  height: 450,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Adjust vertical alignment
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home_work_sharp),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text("تعديل اضافات للمنشأه",
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 70.w),
                          child: Text("الاسم"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 70.w, vertical: 20.h),
                          child: Container(
                            width: 220,
                            child: CustomTextFormField(
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "هذا الحقل مطلوب";
                                }
                              },
                              controller: nameController,
                              padding: EdgeInsets.only(
                                  bottom: 22.h, left: 10.w, right: 10.w),
                              height: 80.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 70.w),
                          child: Text("السعر"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 70.w, vertical: 20.h),
                          child: Container(
                            width: 220,
                            child: CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'هذا الحقل مطلوب';
                                }
                                try {
                                  value = value.replaceAll(',',
                                      '.'); // Remove commas to properly parse the double
                                  double.parse(value);
                                  return null; // Return null if the input is a valid double
                                } catch (e) {
                                  return 'من فضلك ادخل رقم صحيح'; // Error message for invalid input
                                }
                              },
                              controller: priceController,
                              padding: EdgeInsets.only(
                                  bottom: 22.h, left: 10.w, right: 10.w),
                              height: 80.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Align Row to start
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (priceController.text.isNotEmpty &&
                                        nameController.text.isNotEmpty) {
                                      additionalOptionsCubit
                                          .editAdditionalOption(
                                              id: id,
                                              name: nameController.text,
                                              price: priceController.text);
                                    }
                                  }
                                },
                                child: Text("اضافه")),
                            SizedBox(
                              width: 50.w,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text("الغاء")),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
