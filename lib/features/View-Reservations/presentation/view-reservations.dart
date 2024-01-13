import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservationapp_admin/features/View-Waiting-Reservations/business-logic/reservations_cubit/reservations_cubit.dart';

class ViewReservationscreen extends StatelessWidget {
  const ViewReservationscreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationsCubit, ReservationsState>(
      listener: (context, state) {
        if (state is DeclineReservationSuccess) {
          ReservationsCubit.get(context).acceptedReservations = [];
          ReservationsCubit.get(context).getReservations();
        }
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
                                  label: Text('حاله الحجز',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                              DataColumn(
                                  label: Text('الغاء الحجز',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis))),
                            ],
                            rows: cubit.acceptedReservations.map((user) {
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
                                    if (cubit.acceptedReservations
                                                .indexOf(user) %
                                            2 ==
                                        0) {
                                      return Colors.grey[100];
                                    }
                                    return null; // Use default value for other states and odd rows.
                                  },
                                ),
                                cells: [
                                  DataCell(Text(user.user!.name!)),
                                  DataCell(Text(user.categoryName!)),
                                  DataCell(Text(user.item!.name!)),
                                  DataCell(Text(
                                      user.timeOfReservationFrom!.toString())),
                                  DataCell(Text(
                                      user.timeOfReservationTo!.toString())),
                                  DataCell(Container(
                                    width: double.infinity,
                                    child: Text((user.additionalOptions != null)
                                        ? user.additionalOptions!
                                            .replaceAll(RegExp(r'[{}"]'), '')
                                            .replaceAll(',', ', ')
                                            .replaceAll(':', ' : ')
                                        : "لا يوجد اضافات"),
                                  )),
                                  DataCell(Text(user.paid!)),
                                  DataCell(Text((user.status != "2")
                                      ? "تم الحجز"
                                      : "تم الانتهاء من الحجز")),
                                  DataCell((user.status != "2")
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            cubit.declineReservation(
                                                id: user.id!);
                                          })
                                      : Text("تم الانتهاء من الحجز")),
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
