import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/View-Waiting-Reservations/business-logic/reservations_cubit/reservations_cubit.dart';
import 'package:reservationapp_admin/features/View-Waiting-Reservations/data/models/reservations-model.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewWaitingReservationscreen extends StatelessWidget {
  const ViewWaitingReservationscreen({super.key});
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var categoryController = TextEditingController();
    return BlocConsumer<ReservationsCubit, ReservationsState>(
      listener: (context, state) {
        if (state is DeclineReservationSuccess) {
          ReservationsCubit.get(context).waintingReservations = [];
          ReservationsCubit.get(context).getReservations();
        }
        if (state is AcceptReservationSuccess) {
          ReservationsCubit.get(context).waintingReservations = [];
          ReservationsCubit.get(context).getReservations();
        }
      },
      builder: (context, state) {
        var cubit = ReservationsCubit.get(context);
        List<ReservationData> filteredList = [];
        if (searchController.text.isEmpty && categoryController.text.isEmpty) {
          filteredList = cubit.waintingReservations;
        } else {
          filteredList = cubit.waintingReservations
              .where((time) => (time.id != null)
                  ? (categoryController.text.trim() != "")
                      ? (searchController.text.trim() != "")
                          ? time.item!.name!.toLowerCase().contains(
                                  searchController.text.toLowerCase()) &&
                              time.category!.name!
                                  .toLowerCase()
                                  .contains(categoryController.text)
                          : time.category!.name!
                              .toLowerCase()
                              .contains(categoryController.text)
                      : time.item!.name!
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())
                  : false)
              .toList();
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text(' عرض الحجوزات المنتظره'),
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
                      hintText: "ابحث عن منشأه...",
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      controller: categoryController,
                      onChanged: (value) {
                        print(value);
                        filteredList = [];

                        context.read<ReservationsCubit>().getReservations();
                      },
                    ),
                  ),
                ),
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
                        filteredList = [];

                        context.read<ReservationsCubit>().getReservations();
                      },
                    ),
                  ),
                ),
              ],
            ),
            body: (state is GetReservationsLoading)
                ? const CustomLoadingIndicator()
                : (filteredList.isEmpty)
                    ? const Center(
                        child: Text("لا يوجد حجوزات"),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
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
                              padding: const EdgeInsets.all(5.0),
                              child: DataTable(
                                headingRowHeight: 50,
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
                                      label: Text(' التوقيت من',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text(' التوقيت الي',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Text(' اليوم ',
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
                                  // DataColumn(
                                  //     label: Text('تعليقات',
                                  //         style: TextStyle(
                                  //             fontSize: 15,
                                  //             fontWeight: FontWeight.w800,
                                  //             overflow:
                                  //                 TextOverflow.ellipsis))),
                                  DataColumn(
                                      label: Row(
                                    children: [
                                      Text('تاكيد او رفض',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              overflow: TextOverflow.ellipsis)),
                                    ],
                                  )),
                                ],
                                rows: filteredList.map((user) {
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
                                        if (filteredList.indexOf(user) % 2 ==
                                            0) {
                                          return Colors.grey[100];
                                        }
                                        return null; // Use default value for other states and odd rows.
                                      },
                                    ),
                                    cells: [
                                      DataCell(Text((user.user != null)
                                          ? user.user!.name!
                                          : "تم الحذف")),
                                      DataCell(Text(user.categoryName!)),
                                      DataCell(Text(
                                        (user.item == null)
                                            ? "تم الحذف"
                                            : user.item!.name!,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      )),
                                      DataCell(Text(
                                        (user.availableTime == null)
                                            ? "تم الحذف"
                                            : user.availableTime!
                                                .availableTimeFrom!,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      )),
                                      DataCell(Text(
                                        (user.availableTime == null)
                                            ? "تم الحذف"
                                            : user.availableTime!
                                                .availableTimeTo!,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      )),
                                      DataCell(Text(
                                        (user.availableTime == null)
                                            ? "تم الحذف"
                                            : user.availableTime!.day!,
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
                                      // DataCell(Text(
                                      //   (user.comment == null ||
                                      //           user.comment == "")
                                      //       ? "لا يوجد "
                                      //       : user.comment.toString(),
                                      //   style: const TextStyle(
                                      //       overflow: TextOverflow.ellipsis),
                                      // )),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                cubit.acceptReservation(
                                                    id: user.id!,
                                                    context: context);
                                                context.pop();
                                                context.pushNamed(Routes
                                                    .viewWatiningReservationsScreen);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                cubit.declineReservation(
                                                    id: user.id!,
                                                    context: context);
                                              },
                                            )
                                          ],
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

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget buildAdditionalOptions(String? additionalOptions) {
  if (additionalOptions != null &&
      additionalOptions != "[]" &&
      additionalOptions.isNotEmpty) {
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
      return const Text("لا يوجد");
    }
  } else {
    return const Text("لا يوجد ");
  }
}
