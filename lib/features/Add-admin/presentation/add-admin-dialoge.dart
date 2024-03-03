import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/functions/flutter_toast.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/Add-Cashier/business-logic/add-chashier/cubit.dart';
import 'package:reservationapp_admin/features/Add-admin/business-logic/add-admin/cubit.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdminDialoge extends StatelessWidget {
  AddAdminDialoge({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return BlocConsumer<AddAdminCubit, AddAdminState>(
      listener: (context, state) {
        if (state is AddAdminLoading) {
          showLoading();
        }
        if (state is AddAdminSuccess) {
          hideLoading();
          showSuccess("تمت الاضافه");
          context.pop();
        }
        if (state is AddAdminFailure) {
          hideLoading();
          showError("فشل!");
        }
      },
      builder: (context, state) {
        var cubit = AddAdminCubit.get(context);
        return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
                horizontal:
                    (MediaQuery.of(context).size.width > 741) ? 450.w : 165.w),
            child: Container(
              width: double.infinity,
              height: 580,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              padding: const EdgeInsets.all(30),
              child: Form(
                canPop: false,
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Adjust vertical alignment
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Text("اضافه مشرف جديد",
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "هذا الحقل مطلوب";
                                      }
                                      return null;
                                    },
                                    controller: _nameController,
                                    padding: EdgeInsets.only(
                                        bottom: 22.h, left: 10.w, right: 10.w),
                                    height: 80.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70.w),
                                child: const Text("البريد الالكتروني"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 70.w, vertical: 20.h),
                                child: SizedBox(
                                  width: 220,
                                  child: CustomTextFormField(
                                    controller: _usernameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "هذا الحقل مطلوب";
                                      } else if (!value.contains('@') ||
                                          !value.contains('.com')) {
                                        return "ادخل قيمه صحيحه مثل test@test.com";
                                      }
                                      return null;
                                    },
                                    padding: EdgeInsets.only(
                                        bottom: 10.h, left: 10.w, right: 10.w),
                                    height: 80.h,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70.w),
                                child: const Text("كلمه السر"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 70.w, vertical: 20.h),
                                child: SizedBox(
                                  width: 220,
                                  child: CustomTextFormField(
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "هذا الحقل مطلوب";
                                      }
                                      if (_passwordController.text.length < 6) {
                                        return "كلمه السر اقل من 6 حروف";
                                      }
                                      return null;
                                    },
                                    controller: _passwordController,
                                    padding: EdgeInsets.only(
                                        bottom: 22.h, left: 10.w, right: 10.w),
                                    height: 80.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70.w),
                                child: const Text("رقم التليفون"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 70.w, vertical: 20.h),
                                child: SizedBox(
                                  width: 220,
                                  child: CustomTextFormField(
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "هذا الحقل مطلوب";
                                      }
                                      String phoneRegex = r'^\d{8}$';
                                      if (!RegExp(phoneRegex).hasMatch(value)) {
                                        return "ادخل رقم هاتف صحيح";
                                      }
                                      return null;
                                    },
                                    controller: _phoneController,
                                    padding: EdgeInsets.only(
                                        bottom: 10.h, left: 10.w, right: 10.w),
                                    height: 80.h,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 70.w),
                            child: const Text("رقم الهويه"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 70.w, vertical: 20.h),
                            child: SizedBox(
                              width: 220,
                              child: CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  try {
                                    int.parse(value);
                                    return null; // Return null if the input is a valid integer
                                  } catch (e) {
                                    return 'من فضلك ادخل رقم صحيح'; // Error message for invalid input
                                  }
                                },
                                controller: _nationalIdController,
                                padding: EdgeInsets.only(
                                    bottom: 22.h, left: 10.w, right: 10.w),
                                height: 80.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 55.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70.w),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Align Row to start
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState != null) {
                                    if (formKey.currentState!.validate()) {
                                      cubit.AddAdmin(
                                          name: _nameController.text,
                                          email: _usernameController.text,
                                          password: _passwordController.text,
                                          phoneNumber: _phoneController.text,
                                          nid: _nationalIdController.text);
                                    }
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
                        ),
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
