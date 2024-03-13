import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/View-receptionist/business-logic/receptionist_cubit/receptionist_cubit.dart';

class ViewReceptionistScreen extends StatelessWidget {
  ViewReceptionistScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController _changePasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = ReceptionistCubit.get(context);

    return BlocConsumer<ReceptionistCubit, ReceptionistState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          cubit.getReceptionists();
          _changePasswordController.clear();
          context.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('عرض موظفي الاستتقبال'),
                leading: Padding(
                  padding: EdgeInsets.only(right: 50.w),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => context.pop(),
                  ),
                )),
            body: (state is GetReceptionistsLoading)
                ? const CustomLoadingIndicator()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.greyColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DataTable(
                            columns: const [
                              // DataColumn(label: Text("الكود")),
                              DataColumn(label: Text("الاسم")),
                              DataColumn(label: Text('البريد الالكتروني')),
                              DataColumn(label: Text('كلمه السر')),
                              DataColumn(label: Text('رقم الهويه')),
                              DataColumn(label: Text('رقم الهاتف')),
                              DataColumn(label: Text('تغيير كلمه السر')),
                            ],
                            rows: cubit.receptionists.map((user) {
                              return DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    // All rows will have the same selected color.
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.08);
                                    }
                                    // Even rows will have a grey color.
                                    if (cubit.receptionists.indexOf(user) % 2 ==
                                        0) {
                                      return Colors.grey[100];
                                    }
                                    return null; // Use default value for other states and odd rows.
                                  },
                                ),
                                cells: [
                                  // DataCell(Text(user.id.toString())),
                                  DataCell(Text(user.name!)),
                                  DataCell(Text(user.email!)),
                                  DataCell(Text(user.password!)),
                                  DataCell(Text(user.nid!)),
                                  DataCell(Text(user.phone.toString())),
                                  DataCell(
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  insetPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 680.w),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 320,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Colors.white),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Form(
                                                      canPop: false,
                                                      key: formKey,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween, // Adjust vertical alignment
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Center(
                                                              child: Row(
                                                                children: [
                                                                  const SizedBox(
                                                                      width:
                                                                          80),
                                                                  const Icon(
                                                                      Icons
                                                                          .lock),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  const Text(
                                                                      "تغيير كلمه السر",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              24),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 80.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 20),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              70.w),
                                                                      child: const Text(
                                                                          "كلمه السر الجديده"),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: 70
                                                                              .w,
                                                                          vertical:
                                                                              20.h),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            220,
                                                                        child:
                                                                            CustomTextFormField(
                                                                          validator:
                                                                              (String? value) {
                                                                            if (value == null ||
                                                                                value.isEmpty) {
                                                                              return "هذا الحقل مطلوب";
                                                                            }
                                                                            return null;
                                                                          },
                                                                          controller:
                                                                              _changePasswordController,
                                                                          padding: EdgeInsets.only(
                                                                              bottom: 22.h,
                                                                              left: 10.w,
                                                                              right: 10.w),
                                                                          height:
                                                                              70.h,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          70.w),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center, // Align Row to start
                                                                children: [
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (formKey.currentState !=
                                                                            null) {
                                                                          if (formKey
                                                                              .currentState!
                                                                              .validate()) {
                                                                            cubit.changePassword(
                                                                                id: user.id,
                                                                                password: _changePasswordController.text);
                                                                          }
                                                                        }
                                                                      },
                                                                      child: const Text(
                                                                          "تغيير")),
                                                                  SizedBox(
                                                                    width: 50.w,
                                                                  ),
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        context
                                                                            .pop();
                                                                      },
                                                                      child: const Text(
                                                                          "الغاء")),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                            });

                                        // cubit.changePassword(
                                        //     id: user.id.toString());
                                      },
                                    ),
                                  ),

                                  //  DataCell(
                                  // Checkbox(
                                  //   value: user.status!.toString()!,
                                  //   onChanged: (value) {
                                  //     if (value == true) {
                                  //       // context
                                  //       //     .read<UserListCubit>()
                                  //       //     .acceptUser(userList.indexOf(user));
                                  //     } else if (value == false) {
                                  //       // context
                                  //       //     .read<UserListCubit>()
                                  //       //     .rejectUser(userList.indexOf(user));
                                  //     }
                                  //   },
                                  // ),
                                  //    ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ));
      },
    );
  }
}
