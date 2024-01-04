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
  const AuthScreen({super.key});

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
                  Container(
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 400.w, vertical: 30.h),
                    child: CustomButton(
                      text: "login".tr(),
                      height: 60.h,
                      onPressed: () {
                        authCubit.userLogin(
                          email: "salma@gmail.com",
                          password: "000000",
                        );
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
