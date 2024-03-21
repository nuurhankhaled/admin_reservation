import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:reservationapp_admin/features/Add-Items/business-logic/Item_cubit/item_cubit.dart';
import 'package:reservationapp_admin/features/View-category-details/business-logic/category_cubit/category_items_cubit.dart';

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
  String? itemId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryCubit()..getCategories(),
        ),
        BlocProvider(
          create: (context) => CategoryItemsCubit(),
        ),
      ],
      child: BlocConsumer<ItemCubit, ItemState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var itemCubit = CategoryItemsCubit.get(context);
          return BlocConsumer<CategoryCubit, CategoryState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var categoryCubit = CategoryCubit.get(context);
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
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsetsDirectional.only(start: 2.w),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 13.w),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    child: Center(
                                      child: DropdownButtonFormField(
                                        isExpanded: false,
                                        menuMaxHeight: 250,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        hint: const Text("المنشأه",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        items: List.generate(
                                          categoryCubit.categories.length,
                                          (index) => DropdownMenuItem<int>(
                                            value: index,
                                            child: Container(
                                              width: 160,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                // vertical: 10.h,
                                              ),
                                              child: Text(
                                                categoryCubit
                                                    .categories[index].name!,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onChanged: (int? value) {
                                          categoryId = categoryCubit
                                              .categories[value!].id!;
                                          setState(() {
                                            categoryId = categoryCubit
                                                .categories[value].id!;
                                            itemCubit
                                                .getCategoryItems(
                                                    categoryName: categoryCubit
                                                        .categories[value]
                                                        .name!)
                                                .then((value) {
                                              setState(() {
                                                categoryId = "";
                                              });
                                              print(" city id : ");
                                              print(" area id : ");
                                            });
                                          });

                                          setState(() {
                                            categoryId = categoryCubit
                                                .categories[value].id!;
                                            print(" city id : //");
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.5.h, horizontal: 1.w),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 0.3.h, horizontal: 1.w),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        if (itemCubit.categoryItems.isNotEmpty)
                                          Expanded(
                                            child: Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      end: 2.w),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3.w),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp)),
                                              child: Center(
                                                child: DropdownButtonFormField(
                                                  menuMaxHeight: 250,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              InputBorder.none),
                                                  hint: const Text(
                                                    "الوحده",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  items: List.generate(
                                                    itemCubit
                                                        .categoryItems.length,
                                                    (index) {
                                                      return DropdownMenuItem<
                                                              int>(
                                                          value: index,
                                                          child: SizedBox(
                                                            width: 180,
                                                            child: Text(itemCubit
                                                                .categoryItems[
                                                                    index]
                                                                .name!),
                                                          ));
                                                    },
                                                  ),
                                                  onChanged: (int? value) {
                                                    print(itemCubit
                                                        .categoryItems[value!]
                                                        .id);
                                                    print(itemCubit
                                                        .categoryItems[value]
                                                        .name);
                                                    itemId = itemCubit
                                                        .categoryItems[value]
                                                        .id!;
                                                    setState(() {
                                                      itemId = itemCubit
                                                          .categoryItems[value]
                                                          .id!;
                                                    });
                                                    print(
                                                        " area id : $itemId ");
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10.w,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 70.w),
                                  child: const Text(
                                    "التوقيت",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                                  String formattedTime =
                                                      DateFormat('HH:mm:ss',
                                                              'en_US')
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
                                                      DateFormat('HH:mm:ss',
                                                              'en_US')
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
                                                padding:
                                                    EdgeInsets.only(top: 7),
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
                                                  String formattedTime =
                                                      DateFormat('HH:mm:ss',
                                                              'en_US')
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
                                                      DateFormat('HH:mm:ss',
                                                              'en_US')
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
                                                padding:
                                                    EdgeInsets.only(top: 7),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: const Text(
                                    "السعر",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                          bottom: 22.h,
                                          left: 10.w,
                                          right: 10.w),
                                      height: 80.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Align Row to start
                              children: [
                                BlocConsumer<ItemCubit, ItemState>(
                                  listener: (context, state) {
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
                                    var cubit = ItemCubit.get(context);
                                    return ElevatedButton(
                                        onPressed: () {
                                          print("1");
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print("2");
                                            cubit.addAvailableTime(
                                              //   date: formattedDate,
                                              //   date: formattedDate,
                                              availableTimeFrom:
                                                  timeinputFrom.text,
                                              availableTimeTo: timeinputTo.text,
                                              item_id: itemId,
                                              price: price.text,
                                            );
                                          } else {
                                            if (categoryId == null ||
                                                itemId == null) {
                                              showError("اختر الوحده المطلوبه");
                                            }
                                          }
                                        },
                                        child: const Text("اضافه"));
                                  },
                                ),
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
        },
      ),
    );
  }
}
