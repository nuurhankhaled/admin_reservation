import 'package:reservationapp_admin/core/widgets/custom_button.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Items/presentation/add-fields-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItem extends StatelessWidget {
  AddItem({super.key});
  List<String> _statues = ["في الصيانه", "محجوز", "متاح"];
  List<String> _priceState = ["خلال اليوم", "خلال الساعه"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("اضافه عنصر"), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10.w,
              ),
              Column(
                children: [
                  Text(
                    "الصورة الخارجيه",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                ],
              ),
              Column(
                children: [
                  Text(
                    "الصورة الداخليه الاولي",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                          shape: BoxShape.rectangle,
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
                ],
              ),
              Column(
                children: [
                  Text(
                    "الصورة الداخليه الثانيه",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                          shape: BoxShape.rectangle,
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
                ],
              ),
              Column(
                children: [
                  Text(
                    "الصورة الداخليه الثالثه",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                          shape: BoxShape.rectangle,
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
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          SizedBox(
            height: 50.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.w),
                      child: Text(
                        "الاسم",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 40.h),
                      child: Container(
                        width: 420.w,
                        child: CustomTextFormField(
                          backgroundColor: Colors.grey[300],
                          padding: EdgeInsets.only(
                              bottom: 22.h, left: 10.w, right: 10.w),
                          height: 80.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.w),
                      child: Text(
                        "الوصف",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 40.h),
                      child: Container(
                        width: 420.w,
                        child: CustomTextFormField(
                          backgroundColor: Colors.grey[300],
                          padding: EdgeInsets.only(
                              bottom: 22.h, left: 10.w, right: 10.w),
                          height: 80.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.w),
                      child: Text(
                        "الحاله",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 20.h),
                      child: Container(
                        margin: EdgeInsetsDirectional.only(end: 2.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 1.h),
                        height: 80.h,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: Center(
                          child: DropdownButtonFormField(
                            menuMaxHeight: 700.h,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            hint: Text(
                              "اختر الحاله",
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: List.generate(
                              _statues.length,
                              (index) {
                                return DropdownMenuItem<int>(
                                    value: index,
                                    child: Container(
                                      width: 100.w,
                                      child: Text(_statues[index]),
                                    ));
                              },
                            ),
                            onChanged: (int? value) {
                              // areaId =
                              // cubit.cityAreas[value!].id!;
                              // setState(() {
                              //   areaId =
                              //   cubit.cityAreas[value!].id!;
                              // });
                              // print(" area id : $areaId");
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.w),
                      child: Text(
                        "المقتنيات",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 40.h),
                      child: Container(
                        width: 420.w,
                        child: CustomButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddFieldsScreen()));
                          },
                          text: "اضافه",
                          color: Colors.grey[300],
                          textColor: Colors.black,
                          padding: EdgeInsets.only(
                              bottom: 22.h, left: 10.w, right: 10.w),
                          height: 80.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.w),
                      child: Text(
                        "السعر",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 40.h),
                      child: Container(
                        width: 420.w,
                        child: CustomTextFormField(
                          backgroundColor: Colors.grey[300],
                          padding: EdgeInsets.only(
                              bottom: 22.h, left: 10.w, right: 10.w),
                          height: 80.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.w),
                      child: Text(
                        "السعر / الفتره",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 20.h),
                      child: Container(
                        margin: EdgeInsetsDirectional.only(end: 2.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 1.h),
                        height: 80.h,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: Center(
                          child: DropdownButtonFormField(
                            menuMaxHeight: 700.h,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            hint: Text(
                              "اختر الفترة",
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: List.generate(
                              _priceState.length,
                              (index) {
                                return DropdownMenuItem<int>(
                                    value: index,
                                    child: Container(
                                      width: 100.w,
                                      child: Text(_priceState[index]),
                                    ));
                              },
                            ),
                            onChanged: (int? value) {
                              // areaId =
                              // cubit.cityAreas[value!].id!;
                              // setState(() {
                              //   areaId =
                              //   cubit.cityAreas[value!].id!;
                              // });
                              // print(" area id : $areaId");
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 800.w),
            child: CustomButton(
              text: "اضافه عنصر",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50.h,
          )
        ],
      )),
    );
  }
}
