import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/features/View-users/business-logic/users_cubit/users_cubit.dart';
import 'package:reservationapp_admin/features/edit_or_detlete_available_time/bloc/edit_or_delete_cubit.dart';
import 'package:reservationapp_admin/features/edit_or_detlete_available_time/presentation/widgets/edit_time_dialouge.dart';

class ViewAvailableTime extends StatelessWidget {
  const ViewAvailableTime({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditOrDeleteAvailableCubit()..getallAvailable(),
      child: BlocConsumer<EditOrDeleteAvailableCubit, EditOrDeleteStates>(
        listener: (context, state) {
          if (state is EditAvailableSuccess) {
            EditOrDeleteAvailableCubit.get(context).getallAvailable();
          }
        },
        builder: (context, state) {
          var cubit = EditOrDeleteAvailableCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                  title: const Text('عرض الاوقات '),
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
                  : (cubit.allAvailableTimes.isEmpty)
                      ? const Center(
                          child: Text("لا يوجد اوقات حاليا"),
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
                                  columns: const [
                                    DataColumn(label: Text("الكود")),
                                    DataColumn(label: Text("من")),
                                    DataColumn(label: Text('الي')),
                                    DataColumn(label: Text('التاريخ')),
                                    DataColumn(label: Text('السعر')),
                                    DataColumn(label: Text('الحاله')),
                                    DataColumn(label: Text('تعديل')),
                                    DataColumn(label: Text('مسح')),
                                  ],
                                  rows: cubit.allAvailableTimes.map((user) {
                                    return DataRow(
                                      color: MaterialStateProperty.resolveWith<
                                          Color?>(
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
                                          if (cubit.allAvailableTimes
                                                      .indexOf(user) %
                                                  2 ==
                                              0) {
                                            return Colors.grey[100];
                                          }
                                          return null; // Use default value for other states and odd rows.
                                        },
                                      ),
                                      cells: [
                                        DataCell(Text(user.id!)),
                                        DataCell(Text(user.availableTimeFrom!)),
                                        DataCell(Text(user.availableTimeTo!)),
                                        DataCell(Text(user.date!)),
                                        DataCell(Text(user.price!)),
                                        DataCell(Text(user.status!)),
                                        DataCell(
                                          IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BlocProvider(
                                                      create: (context) =>
                                                          EditOrDeleteAvailableCubit(),
                                                      child: EditTimeDialog(
                                                        id: user.id!,
                                                        price: user.price!,
                                                        from: user
                                                            .availableTimeFrom!,
                                                        to: user
                                                            .availableTimeTo!,
                                                        date: user.date!,
                                                        status: user.status!,
                                                      ));
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              cubit.delete(id: user.id!);
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
      ),
    );
  }
}
