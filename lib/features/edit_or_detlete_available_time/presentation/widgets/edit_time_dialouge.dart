import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/edit_or_detlete_available_time/bloc/edit_or_delete_cubit.dart';
import 'package:reservationapp_admin/features/edit_or_detlete_available_time/presentation/edit_or_delete_available_time.dart';

class EditTimeDialog extends StatelessWidget {
  EditTimeDialog(
      {super.key,
      required this.id,
      required this.price,
      required this.from,
      required this.to,
      required this.date,
      required this.status});
  String id;
  String price;
  String from;
  String to;
  String date;
  String status;

  late TextEditingController priceController =
      TextEditingController(text: price);
  File? imageFile;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("id is $id");
    return BlocConsumer<EditOrDeleteAvailableCubit, EditOrDeleteStates>(
      listener: (context, state) {
        if (state is EditAvailableSuccess) {
          context.pop();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ViewAvailableTime()));
        }
      },
      builder: (context, state) {
        var cubit = EditOrDeleteAvailableCubit.get(context);
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
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Adjust vertical alignment
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.home_work_sharp),
                            SizedBox(
                              width: 10.w,
                            ),
                            const Text("تعديل المنشأه",
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 70.w),
                          child: const Text("السعر"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 70.w, vertical: 40.h),
                          child: SizedBox(
                            width: 220,
                            child: CustomTextFormField(
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'هذا الحقل مطلوب';
                                }
                                try {
                                  double.parse(value);
                                  return null; // Return null if the input is a valid integer
                                } catch (e) {
                                  return 'من فضلك ادخل رقم '; // Error message for invalid input
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
                                    if (priceController.text.isNotEmpty) {
                                      cubit.edit(
                                          id: id,
                                          from: from,
                                          to: to,
                                          date: date,
                                          price: priceController.text,
                                          status: status);
                                      priceController.clear();
                                    }
                                  }
                                },
                                child: const Text("تعديل")),
                            SizedBox(
                              width: 50.w,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text("الغاء")),
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
