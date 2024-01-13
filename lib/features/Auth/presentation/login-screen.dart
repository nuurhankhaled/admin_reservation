import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/widgets/custom_button.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/core/widgets/custom_texts.dart';
import 'package:reservationapp_admin/features/Auth/business-logic/auth-cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routing/routes.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          context.pushReplacementNamed(Routes.mainlayout);
        }
      },
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xff3f5e6d),
          body: Center(
            child: Container(
              width: 1100.w,
              height: 800.h,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.login,
                        color: Color(0xff3f5e6d),
                        size: 30,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text28(
                        text: "login".tr(),
                        textColor: Colors.black,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      color: Colors.blue.shade50.withOpacity(0.25),
                      width: 800.w,
                      height: 500.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 70.w),
                            child: Text26(
                              text: "البريد الالكتروني",
                              textColor: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 70.w, vertical: 20.h),
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
                          SizedBox(
                            height: 30.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 70.w),
                            child: Text26(
                              text: "كلمه السر",
                              textColor: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 70.w, vertical: 20.h),
                            child: CustomTextFormField(
                              controller: _passwordController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "هذا الحقل مطلوب";
                                }
                                if (_passwordController.text.length < 6) {
                                  return "كلمه السر اقل من 6 حروف";
                                }
                              },
                              obscureText: authCubit.ispasswordshow,
                              suffixIcon: IconButton(
                                icon: Icon(authCubit.suffixicon),
                                onPressed: () {
                                  authCubit.showLoginpassword();
                                },
                              ),
                              padding: EdgeInsets.only(
                                  bottom: 10.h, left: 10.w, right: 10.w),
                              height: 80.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 400.w, vertical: 30.h),
                    child: CustomButton(
                      text: "login".tr(),
                      height: 60.h,
                      onPressed: () {
                        if (formKey.currentState != null) {
                          if (formKey.currentState!.validate()) {
                            authCubit.userLogin(
                              email: _usernameController.text,
                              password: _passwordController.text,
                            );
                          }
                        }

                        //   context.pushReplacementNamed(Routes.mainlayout);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
