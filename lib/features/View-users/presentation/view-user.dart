import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/features/View-receptionist/business-logic/receptionist_cubit/receptionist_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservationapp_admin/features/View-users/business-logic/accept-user/cubit.dart';
import 'package:reservationapp_admin/features/View-users/business-logic/users_cubit/users_cubit.dart';

class ViewUsersScreen extends StatelessWidget {
  int isAccepted;
  ViewUsersScreen({super.key, required this.isAccepted});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UsersCubit.get(context);
        return Scaffold(
            appBar: AppBar(
                title: (isAccepted == 1)
                    ? const Text('عرض المستخدمين')
                    : const Text('عرض المستحدمين المعلقين'),
                leading: Padding(
                  padding: EdgeInsets.only(right: 50.w),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => context.pop(),
                  ),
                )),
            body: (state is GetAcceptedUsersLoading ||
                    state is GetPendingUsersLoading)
                ? const CustomLoadingIndicator()
                : (isAccepted == 0 && cubit.pendingUsers.isEmpty)
                    ? Center(
                        child: Text("لا يوجد مستخدمين معلقين"),
                      )
                    : (isAccepted == 1 && cubit.acceptedUsers.isEmpty)
                        ? Center(
                            child: Text("لا يوجد مستخدمين"),
                          )
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
                                      const DataColumn(label: Text("الكود")),
                                      const DataColumn(label: Text("الاسم")),
                                      const DataColumn(
                                          label: Text('البريد الالكتروني')),
                                      const DataColumn(
                                          label: Text('كلمه السر')),
                                      const DataColumn(
                                          label: const Text('الرقم القومي')),
                                      const DataColumn(
                                          label: Text('رقم الهاتف')),
                                      const DataColumn(label: Text('الحاله')),
                                      if (isAccepted == 0)
                                        const DataColumn(label: Text('قبول')),
                                    ],
                                    rows: (isAccepted == 1)
                                        ? cubit.acceptedUsers.map((user) {
                                            return DataRow(
                                              color: MaterialStateProperty
                                                  .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                                  // All rows will have the same selected color.
                                                  if (states.contains(
                                                      MaterialState.selected)) {
                                                    return Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.08);
                                                  }
                                                  // Even rows will have a grey color.
                                                  if (cubit.acceptedUsers
                                                              .indexOf(user) %
                                                          2 ==
                                                      0) {
                                                    return Colors.grey[100];
                                                  }
                                                  return null; // Use default value for other states and odd rows.
                                                },
                                              ),
                                              cells: [
                                                DataCell(
                                                    Text(user.id.toString())),
                                                DataCell(Text(user.name!)),
                                                DataCell(Text(user.email!)),
                                                DataCell(Text(user.password!)),
                                                DataCell(Text(user.nid!)),
                                                DataCell(Text(
                                                    user.phone.toString())),
                                                const DataCell(
                                                    Text("تمت قبوله")),
                                              ],
                                            );
                                          }).toList()
                                        : cubit.pendingUsers.map((user) {
                                            return DataRow(
                                              color: MaterialStateProperty
                                                  .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                                  // All rows will have the same selected color.
                                                  if (states.contains(
                                                      MaterialState.selected)) {
                                                    return Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.08);
                                                  }
                                                  // Even rows will have a grey color.
                                                  if (cubit.pendingUsers
                                                              .indexOf(user) %
                                                          2 ==
                                                      0) {
                                                    return Colors.grey[100];
                                                  }
                                                  return null; // Use default value for other states and odd rows.
                                                },
                                              ),
                                              cells: [
                                                DataCell(
                                                    Text(user.id.toString())),
                                                DataCell(Text(user.name!)),
                                                DataCell(Text(user.email!)),
                                                DataCell(Text(user.password!)),
                                                DataCell(Text(user.nid!)),
                                                DataCell(Text(
                                                    user.phone.toString())),
                                                const DataCell(
                                                    Text("لم يتم قبولة بعد")),
                                                DataCell(
                                                  BlocConsumer<AcceptUserCubit,
                                                      AcceptUserState>(
                                                    listener: (context, state) {
                                                      // TODO: implement listener
                                                      if (state
                                                          is AcceptUserSuccess) {
                                                        cubit.getPendingUsers();
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      var acceptUserCubit =
                                                          AcceptUserCubit.get(
                                                              context);
                                                      return IconButton(
                                                        icon: const Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          acceptUserCubit
                                                              .AcceptUser(
                                                            Id: user.id
                                                                .toString(),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
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
