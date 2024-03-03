import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/View-users/business-logic/users_cubit/users_cubit.dart';
import 'package:reservationapp_admin/features/edit_or_detlete_available_time/bloc/edit_or_delete_cubit.dart';
import 'package:reservationapp_admin/features/edit_or_detlete_available_time/model/available_time_model.dart';
import 'package:reservationapp_admin/features/edit_or_detlete_available_time/presentation/widgets/edit_time_dialouge.dart';

class ViewAvailableTime extends StatelessWidget {
  const ViewAvailableTime({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
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
          List<Data> filteredList = [];
          if (searchController.text.isEmpty) {
            filteredList = cubit.allAvailableTimes;
          } else {
            filteredList = cubit.allAvailableTimes
                .where((time) => (time.item != null)
                    ? time.item!.name!
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())
                    : false)
                .toList();
          }
          return Scaffold(
              appBar: AppBar(
                title: const Text('عرض الاوقات '),
                leading: Padding(
                  padding: EdgeInsets.only(right: 50.w),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => context.pop(),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: SizedBox(
                      width: 200,
                      child: CustomTextFormField(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "ابحث عن وحدة...",
                        contentPadding: const EdgeInsets.only(bottom: 15),
                        controller: searchController,
                        onChanged: (value) {
                          context
                              .read<EditOrDeleteAvailableCubit>()
                              .getallAvailable();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              body: (state is GetAcceptedUsersLoading ||
                      state is GetPendingUsersLoading)
                  ? const CustomLoadingIndicator()
                  : (filteredList.isEmpty)
                      ? const Center(
                          child: Text("لا يوجد اوقات "),
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
                                    DataColumn(label: Text("الوحده")),
                                    DataColumn(label: Text("من")),
                                    DataColumn(label: Text('الي')),
                                    DataColumn(label: Text('التاريخ')),
                                    DataColumn(label: Text('السعر')),
                                    DataColumn(label: Text('الحاله')),
                                    DataColumn(label: Text('تعديل')),
                                    DataColumn(label: Text('مسح')),
                                  ],
                                  rows: filteredList.map((user) {
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
                                          if (filteredList.indexOf(user) % 2 ==
                                              0) {
                                            return Colors.grey[100];
                                          }
                                          return null; // Use default value for other states and odd rows.
                                        },
                                      ),
                                      cells: [
                                        DataCell(Text((user.item == null)
                                            ? "تم الحذف"
                                            : user.item!.name!)),
                                        DataCell(Text(user.availableTimeFrom!)),
                                        DataCell(Text(user.availableTimeTo!)),
                                        DataCell(Text(user.date!)),
                                        DataCell(Text(user.price!)),
                                        DataCell(Text(user.status! == "1"
                                            ? "متاح"
                                            : "غير متاح")),
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
