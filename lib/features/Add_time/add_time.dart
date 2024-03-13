import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Items/business-logic/Item_cubit/item_cubit.dart';

class AddTimeDialog extends StatefulWidget {
  const AddTimeDialog({super.key});
  @override
  State<AddTimeDialog> createState() => _AddTimeDialogState();
}

class _AddTimeDialogState extends State<AddTimeDialog> {
  TextEditingController timeinputFrom = TextEditingController();
  TextEditingController timeinputTo = TextEditingController();
  TextEditingController price = TextEditingController();
  //DateTime _selectedDate = DateTime.now();
  //String? formattedDate;
  final _formKey = GlobalKey<FormState>();
  // final CalendarFormat _calendarFormat = CalendarFormat.month;

  String? categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemCubit, ItemState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AddItemLoading) {
          showLoading();
        }
        if (state is AddItemSuccess) {
          hideLoading();
          showSuccess("تمت الاضافه بنجاح");
          context.pop();
        }
        if (state is AddItemFailure) {
          hideLoading();
          showError("حدث خطأ ما");
        }
      },
      builder: (context, state) {
        var itemCubit = ItemCubit.get(context);

        return Form(
          key: _formKey,
          child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.width != 766)
                      ? 650.w
                      : 500.w),
              child: Container(
                width: double.infinity,
                height: 590,
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
                          const Text("اضافه وقت للوحده",
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      SizedBox(
                        width: 220,
                        child: Container(
                          margin: EdgeInsetsDirectional.only(start: 2.w),
                          padding: EdgeInsets.symmetric(horizontal: 13.w),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Center(
                            child: DropdownButtonFormField(
                              isExpanded: false,
                              menuMaxHeight: 250,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              hint: const Text("الوحده",
                                  style: TextStyle(color: Colors.black)),
                              items: List.generate(
                                itemCubit.items.length,
                                (index) => DropdownMenuItem<int>(
                                  value: index,
                                  child: Container(
                                    width: 160,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      // vertical: 10.h,
                                    ),
                                    child: Text(
                                      itemCubit.items[index].name!,
                                    ),
                                  ),
                                ),
                              ),
                              onChanged: (int? value) {
                                categoryId = itemCubit.items[value!].id!;
                                setState(() {
                                  categoryId = itemCubit.items[value].id!;
                                  print(" city id : $categoryId");
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 70.w),
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
                                            String formattedTime =
                                                DateFormat('HH:mm:ss', 'en_US')
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

                                            DateTime parsedTime =
                                                DateFormat('HH:mm:ss', 'en_US')
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
                                          if (value == null || value.isEmpty) {
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
                                            bottom: 8, left: 10.w, right: 10.w),
                                        height: 80.h,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 70.w),
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
                                            String formattedTime =
                                                DateFormat('HH:mm:ss', 'en_US')
                                                    .format(
                                              DateTime(
                                                  2024,
                                                  1,
                                                  1,
                                                  pickedTime.hour,
                                                  pickedTime.minute),
                                            );

                                            print(formattedTime);

                                            DateTime parsedTime =
                                                DateFormat('HH:mm:ss', 'en_US')
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
                                          if (value == null || value.isEmpty) {
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
                                            bottom: 8, left: 10.w, right: 10.w),
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
                                controller: price,
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
                                if (_formKey.currentState!.validate() &&
                                    (categoryId != null || categoryId != "")) {
                                  itemCubit.addAvailableTime(
                                    //   date: formattedDate,
                                    //   date: formattedDate,
                                    availableTimeFrom: timeinputFrom.text,
                                    availableTimeTo: timeinputTo.text,
                                    item_id: categoryId,
                                    price: price.text,
                                  );
                                }
                              },
                              child: const Text("اضافه")),
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
        );
      },
    );
  }
}
