import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/edit_or_detlete_available_time/bloc/edit_or_delete_cubit.dart';
import 'package:reservationapp_admin/features/edit_or_detlete_available_time/presentation/edit_or_delete_available_time.dart';
import 'package:table_calendar/table_calendar.dart';

class EditTimeDialog extends StatefulWidget {
  EditTimeDialog(
      {super.key,
      required this.id,
      required this.price,
      required this.from,
      required this.to,
      // required this.date,
      required this.status});
  String id;
  String price;
  String from;
  String to;
  // String date;
  String status;

  @override
  State<EditTimeDialog> createState() => _EditTimeDialogState();
}

class _EditTimeDialogState extends State<EditTimeDialog> {
  late TextEditingController priceController =
      TextEditingController(text: widget.price);

  File? imageFile;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController timeinputFrom =
      TextEditingController(text: widget.from);

  late TextEditingController timeinputTo =
      TextEditingController(text: widget.to);

  DateTime _selectedDate = DateTime.now();

  String? formattedDate;

  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // formattedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    print("id is ${widget.id}");
    return BlocConsumer<EditOrDeleteAvailableCubit, EditOrDeleteStates>(
      listener: (context, state) {
        if (state is EditAvailableSuccess) {
          context.pop();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ViewAvailableTime()));
        }
      },
      builder: (context, state) {
        var cubit = EditOrDeleteAvailableCubit.get(context);
        return Form(
          key: _formKey,
          child: PopScope(
            canPop: false,
            child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.symmetric(
                    horizontal: (MediaQuery.of(context).size.width != 766)
                        ? 650.w
                        : 500.w),
                child: Container(
                  width: double.infinity,
                  height: 530,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Adjust vertical alignment
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.home_work_sharp),
                            SizedBox(
                              width: 10.w,
                            ),
                            const Text("تعديل المنشأه",
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TableCalendar(
                                            calendarFormat: _calendarFormat,
                                            startingDayOfWeek:
                                                StartingDayOfWeek.sunday,
                                            focusedDay: _selectedDate,
                                            firstDay:
                                                DateTime(DateTime.now().year),
                                            lastDay: DateTime(
                                                DateTime.now().year + 1),
                                            selectedDayPredicate: (date) {
                                              return isSameDay(
                                                  _selectedDate, date);
                                            },
                                            onDaySelected: (date, events) {
                                              print(date);
                                              if (date.isAfter(DateTime.now()
                                                  .subtract(const Duration(
                                                      days: 1)))) {
                                                setState(() {
                                                  _selectedDate = date;
                                                });

                                                formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(_selectedDate);
                                                print(
                                                    "&&&&&&&&&&&&&&&&&&&&&&&&&&");
                                                print(formattedDate);
                                                print(
                                                    "&&&&&&&&&&&&&&&&&&&&&&&&&&");
                                                context.pop();
                                              } else {
                                                // Show a message for past or current date
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return const AlertDialog(
                                                      content: Text(
                                                          "لا يمكن اختيار تاريخ قد مضي"),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            calendarStyle: const CalendarStyle(
                                              // weekendTextStyle: TextStyle(color: Colors.red),
                                              selectedTextStyle: TextStyle(
                                                  color: Colors.white),
                                              selectedDecoration: BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                              ),
                                              // markersColor: Colors.green,
                                            ),
                                            headerStyle: const HeaderStyle(
                                              formatButtonVisible: true,
                                              titleCentered: true,
                                              titleTextStyle:
                                                  TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            if (formattedDate != null)
                              Text("التاريخ المختار  : ${formattedDate!}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 6, 103, 182))),
                            SizedBox(
                              height: 10.w,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70.w),
                              child: const Text(
                                "التوقيت",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 70.w),
                                      child: const Text(
                                        " من صباحا",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w, vertical: 40.h),
                                      child: SizedBox(
                                        width: 190.w,
                                        child: CustomTextFormField(
                                          readOnly: true,
                                          onTap: () async {
                                            TimeOfDay? pickedTime =
                                                await showTimePicker(
                                              initialTime: TimeOfDay.now(),
                                              context: context,
                                            );

                                            if (pickedTime != null) {
                                              // Explicitly set the locale to English when formatting and parsing
                                              String formattedTime = DateFormat(
                                                      'HH:mm:ss', 'en_US')
                                                  .format(
                                                DateTime(
                                                  2024,
                                                  1,
                                                  1,
                                                  pickedTime.hour,
                                                  pickedTime.minute,
                                                ),
                                              );

                                              print(formattedTime);

                                              DateTime parsedTime = DateFormat(
                                                      'HH:mm:ss', 'en_US')
                                                  .parse(
                                                formattedTime,
                                              );
                                              // Converting to DateTime so that we can further format on a different pattern.
                                              print(
                                                  parsedTime); // Output: 1970-01-01 22:53:00.000
                                              String finalFormattedTime =
                                                  DateFormat('HH:mm:ss')
                                                      .format(parsedTime);
                                              print(
                                                  finalFormattedTime); // Output: 14:59:00
                                              // DateFormat() is from the intl package, and you can format the time in any pattern you need.

                                              setState(() {
                                                timeinputFrom.text =
                                                    formattedTime; // Set the value of the text field.
                                              });
                                            } else {
                                              print("Time is not selected");
                                            }
                                          },
                                          controller: timeinputFrom,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "هذا الحقل مطلوب";
                                            }
                                            return null;
                                          },
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.only(top: 7),
                                            child: Icon(
                                              Icons.timer,
                                              size: 25,
                                            ),
                                          ),
                                          backgroundColor: Colors.grey[300],
                                          padding: EdgeInsets.only(
                                              bottom: 8,
                                              left: 10.w,
                                              right: 10.w),
                                          height: 80.h,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 70.w),
                                      child: const Text(
                                        " الي مساءا",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w, vertical: 40.h),
                                      child: SizedBox(
                                        width: 190.w,
                                        child: CustomTextFormField(
                                          readOnly: true,
                                          onTap: () async {
                                            TimeOfDay? pickedTime =
                                                await showTimePicker(
                                              initialTime: TimeOfDay.now(),
                                              context: context,
                                            );

                                            if (pickedTime != null) {
                                              // Explicitly set the locale to English when formatting and parsing
                                              String formattedTime = DateFormat(
                                                      'HH:mm:ss', 'en_US')
                                                  .format(
                                                DateTime(
                                                    2024,
                                                    1,
                                                    1,
                                                    pickedTime.hour,
                                                    pickedTime.minute),
                                              );

                                              print(formattedTime);

                                              DateTime parsedTime = DateFormat(
                                                      'HH:mm:ss', 'en_US')
                                                  .parse(
                                                formattedTime,
                                              );
                                              //converting to DateTime so that we can further format on different pattern.
                                              print(
                                                  parsedTime); //output 1970-01-01 22:53:00.000
                                              String finalFormattedTime =
                                                  DateFormat('HH:mm:ss')
                                                      .format(parsedTime);
                                              print(
                                                  finalFormattedTime); //output 14:59:00
                                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                                              setState(() {
                                                timeinputTo.text =
                                                    formattedTime; //set the value of text field.
                                                print(timeinputTo.text);
                                              });
                                            } else {
                                              print("Time is not selected");
                                            }
                                          },
                                          controller: timeinputTo,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "هذا الحقل مطلوب";
                                            }
                                            return null;
                                          },
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.only(top: 7),
                                            child: Icon(
                                              Icons.timer,
                                              size: 25,
                                            ),
                                          ),
                                          backgroundColor: Colors.grey[300],
                                          padding: EdgeInsets.only(
                                              bottom: 8,
                                              left: 10.w,
                                              right: 10.w),
                                          height: 80.h,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: const Text(
                                "السعر",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.w, vertical: 40.h),
                              child: SizedBox(
                                width: 420.w,
                                child: CustomTextFormField(
                                  controller: priceController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'هذا الحقل مطلوب';
                                    }
                                    try {
                                      double.parse(value);
                                      return null; // Return null if the input is a valid integer
                                    } catch (e) {
                                      return 'من فضلك ادخل رقم صحيح'; // Error message for invalid input
                                    }
                                  },
                                  backgroundColor: Colors.grey[300],
                                  padding: EdgeInsets.only(
                                      bottom: 22.h, left: 10.w, right: 10.w),
                                  height: 80.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Align Row to start
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  print("id is ${widget.id}");
                                  print("status is ${widget.status}");
                                  print("price is ${priceController.text}");
                                  print("from is ${timeinputFrom.text}");
                                  print("to is ${timeinputTo.text}");
                                  print("date is $formattedDate");

                                  if (_formKey.currentState!.validate()) {
                                    if (priceController.text.isNotEmpty) {
                                      cubit.edit(
                                          id: widget.id,
                                          from: timeinputFrom.text,
                                          to: timeinputTo.text,
                                          date: formattedDate,
                                          price: priceController.text,
                                          status: widget.status);
                                      priceController.clear();
                                      timeinputFrom.clear();
                                      timeinputTo.clear();
                                    }
                                  }
                                },
                                child: const Text("تعديل")),
                            SizedBox(
                              width: 50.w,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text("الغاء")),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
