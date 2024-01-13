import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservationapp_admin/features/View-Waiting-Reservations/business-logic/reservations_cubit/reservations_cubit.dart';

class ViewWaitingReservationscreen extends StatelessWidget {
  ViewWaitingReservationscreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationsCubit, ReservationsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ReservationsCubit.get(context);
        return Scaffold(
            appBar: AppBar(
                title: Text('عرض الحجوزات '),
                leading: Padding(
                  padding: EdgeInsets.only(right: 50.w),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => context.pop(),
                  ),
                )),
            body: (state is GetReservationsLoading)
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
                            columns: const [
                              DataColumn(
                                  label: Text("اسم المستخدم",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                              DataColumn(
                                  label: Text(' المنشاه',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                              DataColumn(
                                  label: Text(' المحجوز',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                              DataColumn(
                                  label: Text(' توقيت الحجز من',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                              DataColumn(
                                  label: Text(' توقيت الحجز الي',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                              DataColumn(
                                  label: Text('اضافات',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                              DataColumn(
                                  label: Text('المدفوع',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                              DataColumn(
                                  label: Text('تأكيد الحجز',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                              DataColumn(
                                  label: Text('رفض الحجز',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                            ],
                            rows: cubit.waintingReservations.map((user) {
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
                                    if (cubit.waintingReservations
                                                .indexOf(user) %
                                            2 ==
                                        0) {
                                      return Colors.grey[100];
                                    }
                                    return null; // Use default value for other states and odd rows.
                                  },
                                ),
                                cells: [
                                  DataCell(Text((user.user != null)
                                      ? user.user!.name!
                                      : "غير مسجل بعد")),
                                  DataCell(Text(user.categoryName!)),
                                  DataCell(Text("user.item!.name!")),
                                  DataCell(Text(
                                      user.timeOfReservationFrom!.toString())),
                                  DataCell(Text(
                                      user.timeOfReservationTo!.toString())),
                                  DataCell(SizedBox(
                                    width: double.infinity,
                                    child: Text((user.additionalOptions != null)
                                        ? user.additionalOptions!
                                            .replaceAll(RegExp(r'[{}"]'), '')
                                            .replaceAll(',', ', ')
                                            .replaceAll(':', ' : ')
                                        : "لا يوجد اضافات"),
                                  )),
                                  DataCell(Text((user.paid != "")
                                      ? user.paid!
                                      : "لا يوجد مبلغ مدفوع")),
                                  DataCell(
                                    IconButton(
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        cubit.acceptReservation(
                                            id: user.id!, context: context);
                                        context.pop();
                                        context.pushNamed(Routes
                                            .viewWatiningReservationsScreen);
                                      },
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          cubit.declineReservation(
                                              id: user.id!, context: context);
                                          ReservationsCubit.get(context)
                                              .getReservations();
                                        },
                                      ),
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
