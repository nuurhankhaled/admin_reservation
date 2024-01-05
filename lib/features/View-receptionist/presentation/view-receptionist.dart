import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/features/View-receptionist/business-logic/receptionist_cubit/receptionist_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewReceptionistScreen extends StatelessWidget {
  ViewReceptionistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceptionistCubit, ReceptionistState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ReceptionistCubit.get(context);
        return Scaffold(
            appBar: AppBar(
                title: Text('عرض موظفي الاستتقبال'),
                leading: Padding(
                  padding: EdgeInsets.only(right: 50.w),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => context.pop(),
                  ),
                )),
            body: (state is GetReceptionistsLoading)
                ? CustomLoadingIndicator()
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
                            columns: [
                              DataColumn(label: Text("الكود")),
                              DataColumn(label: Text("الاسم")),
                              DataColumn(label: Text('البريد الالكتروني')),
                              DataColumn(label: Text('كلمه السر')),
                              DataColumn(label: Text('الرقم القومي')),
                              DataColumn(label: Text('رقم الهاتف')),
                              DataColumn(label: Text('الحاله')),
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
                                  DataCell(Text(user.id.toString())),
                                  DataCell(Text(user.name!)),
                                  DataCell(Text(user.email!)),
                                  DataCell(Text(user.password!)),
                                  DataCell(Text(user.nid!)),
                                  DataCell(Text(user.phone.toString())),
                                  DataCell(Text((user.status == "1")
                                      ? "تمت قبوله"
                                      : "لم يتم قبولة بعد")),
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
