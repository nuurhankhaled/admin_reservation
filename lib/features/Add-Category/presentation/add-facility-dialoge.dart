import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';

class AddCategoryDialog extends StatelessWidget {
  AddCategoryDialog({super.key});

  File? pickedImage; // Variable to store the selected image
  late TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is AddCategorySuccess) {
          context.pop();
        }
      },
      builder: (context, state) {
        var addFacilityCubit = CategoryCubit.get(context);
        return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
                horizontal:
                    (MediaQuery.of(context).size.width != 766) ? 650.w : 500.w),
            child: Form(
              key: formKey,
              child: Container(
                width: double.infinity,
                height: 550,
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
                          Text("addAFacility".tr(),
                              style: const TextStyle(fontSize: 24),
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
                              image: addFacilityCubit.pickedImage != null
                                  ? DecorationImage(
                                      image: FileImage(
                                          addFacilityCubit.pickedImage!),
                                      fit: BoxFit.contain,
                                    )
                                  : const DecorationImage(
                                      image:
                                          AssetImage("assets/images/loggo.png"),
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
                                      addFacilityCubit.pickImage(
                                          ImageSource.gallery, context);
                                      pickedImage =
                                          addFacilityCubit.pickedImage;
                                    },
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70.w),
                        child: const Text("الاسم"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 70.w, vertical: 20.h),
                        child: SizedBox(
                          width: 220,
                          child: CustomTextFormField(
                            controller: nameController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "هذا الحقل مطلوب";
                              }
                              return null;
                            },
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
                                if (formKey.currentState != null) {
                                  if (formKey.currentState!.validate() &&
                                      pickedImage != null) {
                                    addFacilityCubit.addCategory(
                                        image: addFacilityCubit.pickedImage,
                                        name: nameController.text,
                                        context: context);
                                    // pickedImage = addFacilityCubit.pickedImage;
                                    nameController.clear();
                                    CategoryCubit().getCategories();
                                  } else {
                                    showError("من فضلك ادخل البيانات المطلوبه");
                                  }
                                } else {
                                  showError("من فضلك ادخل البيانات المطلوبه");
                                }
                              },
                              child: const Text("اضافه")),
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
              ),
            ));
      },
    );
  }
}
