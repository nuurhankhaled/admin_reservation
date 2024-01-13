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

class EditCategoryDialog extends StatelessWidget {
  EditCategoryDialog(
      {super.key, required this.id, required this.name, required this.image});
  String id;
  String name;
  String image;
  late TextEditingController nameController = TextEditingController(text: name);
  File? imageFile;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("id is $id");
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is EditCategorySuccess) {
          context.pop();
          context.pushReplacementNamed(Routes.viewCategoriesScreen);
        }
      },
      builder: (context, state) {
        var categoryCubit = CategoryCubit.get(context);
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
                  height: 600,
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
                            Text("تعديل المنشأه",
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 400.w,
                              height: 320.h,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: -1,
                                      blurRadius: 5)
                                ],
                                shape: BoxShape.circle,
                                color: Colors.deepPurple.shade50,
                                image: categoryCubit.updatedImage != null
                                    ? DecorationImage(
                                        image: FileImage(
                                            categoryCubit.updatedImage!),
                                        fit: BoxFit.contain,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 220.3.h, left: 47.w, right: 47.w),
                                child: Container(
                                    width: 80.w,
                                    height: 94.7.h,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 7.w, color: Colors.white)),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 30.w,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        categoryCubit.pickUpdateImage(
                                            ImageSource.gallery, context);
                                        imageFile = categoryCubit.updatedImage;
                                      },
                                    ))),
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
                              horizontal: 70.w, vertical: 40.h),
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
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Align Row to start
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (nameController.text.isNotEmpty) {
                                      categoryCubit.editCategory(
                                          id: id,
                                          name: nameController.text,
                                          image: categoryCubit.updatedImage,
                                          context: context);
                                      nameController.clear();
                                    }
                                  }
                                },
                                child: Text("تعديل")),
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
