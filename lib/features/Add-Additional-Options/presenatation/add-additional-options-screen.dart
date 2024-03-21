import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Additional-Options/business-logic/additional_options_cubit/additional_options_cubit.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:reservationapp_admin/features/Add-Items/business-logic/Item_cubit/item_cubit.dart';
import 'package:reservationapp_admin/features/View-category-details/business-logic/category_cubit/category_items_cubit.dart';

class AddAdditionalOptionsDialog extends StatefulWidget {
  const AddAdditionalOptionsDialog({super.key});

  @override
  State<AddAdditionalOptionsDialog> createState() =>
      _AddAdditionalOptionsDialogState();
}

class _AddAdditionalOptionsDialogState
    extends State<AddAdditionalOptionsDialog> {
  late TextEditingController nameController = TextEditingController();

  late TextEditingController priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
          var categoryCubit = CategoryCubit.get(context);
          return BlocConsumer<AdditionalOptionsCubit, AdditionalOptionsState>(
            listener: (context, state) {
              if (state is AddAdditionalOptionsSuccess) {
                context.pop();
              }
            },
            builder: (context, state) {
              var additionalOptionsCubit = AdditionalOptionsCubit.get(context);
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
                      height: 585,
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
                                const Text("اضافه اضافات للوحده",
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
                                                  color: Colors.grey[200],
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
                                                    print(" area id : // ");
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
                            SizedBox(
                              height: 50.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70.w),
                              child: const Text("الاسم"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 70.w, vertical: 20.h),
                              child: SizedBox(
                                width: 220,
                                child: CustomTextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "هذا الحقل مطلوب";
                                    }
                                    return null;
                                  },
                                  controller: nameController,
                                  padding: EdgeInsets.only(
                                      bottom: 22.h, left: 10.w, right: 10.w),
                                  height: 80.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70.w),
                              child: const Text("السعر"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 70.w, vertical: 20.h),
                              child: SizedBox(
                                width: 220,
                                child: CustomTextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'هذا الحقل مطلوب';
                                    }
                                    try {
                                      value = value.replaceAll(',',
                                          '.'); // Remove commas to properly parse the double
                                      double.parse(value);
                                      return null; // Return null if the input is a valid double
                                    } catch (e) {
                                      return 'من فضلك ادخل رقم صحيح'; // Error message for invalid input
                                    }
                                  },
                                  controller: priceController,
                                  padding: EdgeInsets.only(
                                      bottom: 22.h, left: 10.w, right: 10.w),
                                  height: 80.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Align Row to start
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (priceController.text.isNotEmpty &&
                                            nameController.text.isNotEmpty &&
                                            categoryId != null) {
                                          additionalOptionsCubit
                                              .AddAdditionalOptions(
                                                  itemId: itemId,
                                                  name: nameController.text,
                                                  price: priceController.text,
                                                  context: context);
                                          nameController.clear();
                                        }
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
        },
      ),
    );
  }
}
