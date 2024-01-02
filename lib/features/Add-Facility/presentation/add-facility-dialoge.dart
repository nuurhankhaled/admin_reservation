import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Facility/business-logic/add_facility_cubit/add_facility_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFacilityDialog extends StatelessWidget {
  const AddFacilityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFacilityCubit, AddFacilityState>(
      listener: (context, state) {},
      builder: (context, state) {
        var addFacilityCubit = AddFacilityCubit.get(context);
        return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
                horizontal:
                    (MediaQuery.of(context).size.width != 766) ? 650.w : 500.w),
            child: Container(
              width: double.infinity,
              height: 600,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
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
                        Text("addAFacility".tr(),
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
                            image: const DecorationImage(
                              image: AssetImage("assets/images/loggo.png"),
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
                                  onPressed:
                                      // (editable)
                                      //     ? () {
                                      //         showDialog(
                                      //             context: context,
                                      //             builder:
                                      //                 (context) {
                                      //               return AlertDialog(
                                      //                 title: Text(
                                      //                     LocaleKeys
                                      //                         .changeImage
                                      //                         .tr()),
                                      //                 content:
                                      //                     Column(
                                      //                   mainAxisSize:
                                      //                       MainAxisSize
                                      //                           .min,
                                      //                   children: [
                                      //                     TextButton(
                                      // onPressed:
                                      //     () {
                                      //   updateUserCubit.pickImage(ImageSource.gallery,
                                      //       context);
                                      //   Navigator.pop(context);
                                      //   ProfileCubit.get(context).getProfile(context);
                                      // },
                                      // child: Text(LocaleKeys
                                      //     .pickFromDevice
                                      //     .tr())),
                                      //                 TextButton(
                                      //                     onPressed:
                                      //                         () {
                                      //                       updateUserCubit.pickImage(ImageSource.camera,
                                      //                           context);
                                      //                       Navigator.pop(context);
                                      //                     },
                                      //                     child: Text(LocaleKeys
                                      //                         .pickFromCamera
                                      //                         .tr())),
                                      //               ],
                                      //             ),
                                      //           );
                                      //         });
                                      //   }
                                      // :
                                      () {},
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
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
                              context.pushNamed(Routes.addItem);
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
            ));
      },
    );
  }
}
