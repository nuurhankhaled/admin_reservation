import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/features/View-Waiting-Reservations/business-logic/reservations_cubit/reservations_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

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
                title: const Text('عرض الحجوزات '),
                leading: Padding(
                  padding: EdgeInsets.only(right: 50.w),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => context.pop(),
                  ),
                )),
            body: (state is GetReservationsLoading)
                ? const CustomLoadingIndicator()
                : (cubit.acceptedReservations.isEmpty)
                    ? const Center(
                        child: Text("لا يوجد حجوزات"),
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
                                  DataColumn(
                                      label: Text("اسم المستخدم",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text(' المنشاه',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text(' المحجوز',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text('كود التوقيت',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text('القسيمه',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text('اثبات الدفع',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text('اضافات',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text('المدفوع',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text('الاجمالي',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text('حاله الحجز',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text('الغاء الحجز',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                ],
                                rows: cubit.acceptedReservations.map((user) {
                                  return DataRow(
                                    color: MaterialStateProperty.resolveWith<
                                        Color?>(
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
                                      DataCell(Text(
                                        (user.user != null)
                                            ? user.user!.name!
                                            : user.userId!,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      )),
                                      DataCell(Text(
                                        (user.categoryName != null)
                                            ? user.categoryName!
                                            : "تم الحذف",
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      )),
                                      DataCell(Text(
                                        (user.item != null)
                                            ? user.item!.name!
                                            : "تم الحذف",
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      )),
                                      DataCell(Text(
                                        (user.packageId != null)
                                            ? user.packageId.toString()
                                            : "تم الحذف",
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      )),
                                      DataCell((user.document == null ||
                                              user.document == "")
                                          ? const Text("لا يوجد  ")
                                          : TextButton(
                                              style: TextButton.styleFrom(
                                                alignment: Alignment.center,
                                                foregroundColor: Colors.blue,
                                              ),
                                              onPressed: () {
                                                _launchURL(user.document!);
                                              },
                                              child: const Text('اضغط هنا'),
                                            )),
                                      DataCell(
                                        (user.approveOfPayment == null ||
                                                user.approveOfPayment == "")
                                            ? const Text("لا يوجد  ")
                                            : TextButton(
                                                style: TextButton.styleFrom(
                                                  alignment: Alignment.center,
                                                  foregroundColor: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  _launchURL(
                                                      user.approveOfPayment!);
                                                },
                                                child: const Text('اضغط هنا'),
                                              ),
                                      ),
                                      DataCell(SizedBox(
                                          width: double.infinity,
                                          child: buildAdditionalOptions(
                                              user.additionalOptions))),
                                      DataCell(Text(
                                          (user.paid == "" || user.paid == null)
                                              ? "لا يوجد  "
                                              : user.paid!)),
                                      DataCell(Text(user.price!)),
                                      DataCell(Text((user.status != "2")
                                          ? "تم الحجز"
                                          : "تم الانتهاء  ")),
                                      DataCell((user.status != "2")
                                          ? IconButton(
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                cubit.declineReservation(
                                                    id: user.id!);
                                              })
                                          : const Text("تم الانتهاء  ")),
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

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget buildAdditionalOptions(String? additionalOptions) {
  if (additionalOptions != null &&
      additionalOptions.isNotEmpty &&
      additionalOptions != "[]") {
    try {
      // Attempt to decode the additional options string
      List<Map<String, dynamic>> optionsList =
          List<Map<String, dynamic>>.from(json.decode(additionalOptions));

      // Extract the 'name' and 'price' values for each option
      List<String> formattedOptions = optionsList
          .map((option) => '${option["name"]} : ${option["price"]}')
          .toList();

      // Join the formatted options into a single string
      String formattedString = formattedOptions.join(', ');

      return Text(formattedString);
    } catch (e) {
      // Handle decoding error
      print('Error decoding additional options: $e');
      return const Text("Error decoding options");
    }
  } else {
    return const Text("لا يوجد ");
  }
}
