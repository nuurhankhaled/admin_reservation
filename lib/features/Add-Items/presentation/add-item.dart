import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/core/widgets/custom_button.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:reservationapp_admin/features/Add-Items/business-logic/Item_cubit/item_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final List<String> _statues = ["في الصيانه", "متاح", "محجوز"];
  final List<String> _priceState = ["خلال اليوم", "خلال الساعه"];

  List<Map<String, String>> devicesList = [];

  File? pickedLogo; // Variable to store the selected image
  File? pickedImage1; // Variable to store the selected image
  File? pickedImage2; // Variable to store the selected image
  File? pickedImage3; // Variable to store the selected image
//  final DateTime _selectedDate = DateTime.now();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController address = TextEditingController();
  // TextEditingController price = TextEditingController();
  TextEditingController offers = TextEditingController();
  //TextEditingController timeinputFrom = TextEditingController();
  // TextEditingController timeinputTo = TextEditingController();

  String? categoryName;
  int? statue;
  //String? priceDuaration;
  String? formattedDate;

  final List<TextEditingController> _items = [];
  final List<TextEditingController> _quantity = [];

  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  _addField() {
    setState(() {
      _items.add(TextEditingController());
      _quantity.add(TextEditingController());
    });
  }

  _removeField(i) {
    setState(() {
      _items.removeAt(i);
      _quantity.removeAt(i);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addField();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemCubit, ItemState>(
      listener: (context, state) {
        if (state is AddItemSuccess) {
          context.pop();
          //    context.pushReplacementNamed(Routes.mainlayout);
        }
      },
      builder: (context, state) {
        var categoryCubit = CategoryCubit.get(context);

        return BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            var itemCubit = ItemCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "اضافه عنصر",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                elevation: 0,
                leading: Padding(
                  padding: EdgeInsets.only(right: 50.w),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => context.pop(),
                  ),
                ),
                actions: [
                  const Text("اختر ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 20.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 100, top: 10.h),
                    child: SizedBox(
                      width: 220,
                      child: Container(
                        margin: EdgeInsetsDirectional.only(start: 2.w),
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        height: 45,
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
                            hint: const Text("المنشأه",
                                style: TextStyle(color: Colors.black)),
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
                                    categoryCubit.categories[index].name!,
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (int? value) {
                              categoryName =
                                  categoryCubit.categories[value!].name!;
                              setState(() {
                                categoryName =
                                    categoryCubit.categories[value].name!;
                                print(" city id : $categoryName");
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                  child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          children: [
                            const Text(
                              "الصورة الخارجيه",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 400.w,
                                  height: 320.h,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: -1,
                                          blurRadius: 5)
                                    ],
                                    shape: BoxShape.circle,
                                    color: Colors.deepPurple.shade50,
                                    image: itemCubit.pickedLogo != null
                                        ? DecorationImage(
                                            image: FileImage(
                                                itemCubit.pickedLogo!),
                                            fit: BoxFit.contain,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/loggo.png"),
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 220.3.h, left: 47.w, right: 47.w),
                                    child: Container(
                                        width: 80.w,
                                        height: 94.7.h,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 7.w,
                                                color: Colors.white)),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt_rounded,
                                            size: 30.w,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            itemCubit.pickLogo(
                                              ImageSource.gallery,
                                            );
                                            pickedLogo = itemCubit.pickedLogo;
                                          },
                                        ))),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "الصورة الداخليه الاولي",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 400.w,
                                  height: 320.h,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: -1,
                                          blurRadius: 5)
                                    ],
                                    shape: BoxShape.rectangle,
                                    color: Colors.deepPurple.shade50,
                                    image: itemCubit.pickedImage1 != null
                                        ? DecorationImage(
                                            image: FileImage(
                                                itemCubit.pickedImage1!),
                                            fit: BoxFit.contain,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/loggo.png"),
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 220.3.h, left: 47.w, right: 47.w),
                                    child: Container(
                                        width: 80.w,
                                        height: 94.7.h,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 7.w,
                                                color: Colors.white)),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt_rounded,
                                            size: 30.w,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            itemCubit.pickImage1(
                                                ImageSource.gallery, context);
                                            pickedLogo = itemCubit.pickedImage1;
                                          },
                                        ))),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "الصورة الداخليه الثانيه",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 400.w,
                                  height: 320.h,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: -1,
                                          blurRadius: 5)
                                    ],
                                    shape: BoxShape.rectangle,
                                    color: Colors.deepPurple.shade50,
                                    image: itemCubit.pickedImage2 != null
                                        ? DecorationImage(
                                            image: FileImage(
                                                itemCubit.pickedImage2!),
                                            fit: BoxFit.contain,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/loggo.png"),
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 220.3.h, left: 47.w, right: 47.w),
                                    child: Container(
                                        width: 80.w,
                                        height: 94.7.h,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 7.w,
                                                color: Colors.white)),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt_rounded,
                                            size: 30.w,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            itemCubit.pickImage2(
                                                ImageSource.gallery, context);
                                            pickedLogo = itemCubit.pickedImage2;
                                          },
                                        ))),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "الصورة الداخليه الثالثه",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 400.w,
                                  height: 320.h,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: -1,
                                          blurRadius: 5)
                                    ],
                                    shape: BoxShape.rectangle,
                                    color: Colors.deepPurple.shade50,
                                    image: itemCubit.pickedImage3 != null
                                        ? DecorationImage(
                                            image: FileImage(
                                                itemCubit.pickedImage3!),
                                            fit: BoxFit.contain,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/loggo.png"),
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 220.3.h, left: 47.w, right: 47.w),
                                    child: Container(
                                        width: 80.w,
                                        height: 94.7.h,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 7.w,
                                                color: Colors.white)),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt_rounded,
                                            size: 30.w,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            itemCubit.pickImage3(
                                                ImageSource.gallery, context);
                                            pickedLogo = itemCubit.pickedImage3;
                                          },
                                        ))),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70.w),
                              child: const Text(
                                "الاسم",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 40.h),
                              child: SizedBox(
                                width: 420.w,
                                child: CustomTextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "هذا الحقل مطلوب";
                                    }
                                    return null;
                                  },
                                  controller: name,
                                  backgroundColor: Colors.grey[300],
                                  padding: EdgeInsets.only(
                                      bottom: 22.h, left: 10.w, right: 10.w),
                                  height: 80.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70.w),
                              child: const Text(
                                "الوصف",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 40.h),
                              child: SizedBox(
                                width: 420.w,
                                child: CustomTextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "هذا الحقل مطلوب";
                                    }
                                    return null;
                                  },
                                  controller: description,
                                  backgroundColor: Colors.grey[300],
                                  padding: EdgeInsets.only(
                                      bottom: 22.h, left: 10.w, right: 10.w),
                                  height: 80.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70.w),
                              child: const Text(
                                "الحاله",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 70.w, vertical: 20.h),
                              child: Container(
                                margin: EdgeInsetsDirectional.only(end: 2.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 1.h),
                                height: 80.h,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10.sp)),
                                child: Center(
                                  child: DropdownButtonFormField(
                                    menuMaxHeight: 700.h,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                    hint: const Text(
                                      "اختر الحاله",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    items: List.generate(
                                      _statues.length,
                                      (index) {
                                        return DropdownMenuItem<int>(
                                            value: index,
                                            child: SizedBox(
                                              width: 130.w,
                                              child: Text(_statues[index]),
                                            ));
                                      },
                                    ),
                                    onChanged: (int? value) {
                                      setState(() {
                                        statue = value;
                                      });
                                      print('statue : $statue');
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: const Text(
                                "العنوان",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 40.h),
                              child: SizedBox(
                                width: 420.w,
                                child: CustomTextFormField(
                                  controller: address,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "هذا الحقل مطلوب";
                                    }
                                    return null;
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                              child: const Text(
                                "  العروض \"اتركها فارغه اذا لم يتواجد\" ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 40.h),
                              child: SizedBox(
                                width: 420.w,
                                child: CustomTextFormField(
                                  controller: offers,
                                  backgroundColor: Colors.grey[300],
                                  padding: EdgeInsets.only(
                                      bottom: 22.h, left: 10.w, right: 10.w),
                                  height: 80.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 170.w),
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _addField();
                              },
                              child: Icon(
                                Icons.add_circle,
                                size: 30,
                                color: Colors.green[500],
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Text("اضافه ",
                                style: TextStyle(
                                    color: Colors.green[500],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          for (int i = 0; i < _items.length; i++)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(38.sp),
                                      child: SizedBox(
                                        width: 500,
                                        height: 70,
                                        child: CustomTextFormField(
                                            backgroundColor: Colors.grey[300],
                                            padding: EdgeInsets.only(
                                                bottom: 22.h,
                                                left: 10.w,
                                                right: 10.w),
                                            controller: _items[i],
                                            validator: (value) {
                                              if (value == "") {
                                                return "هذا الحقل مطلوب";
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.text,
                                            labelText: "اضافه مقتنيه"),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(38.sp),
                                      child: SizedBox(
                                        width: 110,
                                        child: CustomTextFormField(
                                            height: 70,
                                            backgroundColor: Colors.grey[300],
                                            padding: EdgeInsets.only(
                                                bottom: 22.h,
                                                left: 10.w,
                                                right: 10.w),
                                            controller: _quantity[i],
                                            validator: (value) {
                                              if (value == "") {
                                                return "ادخل الحقل الفارغ";
                                              }
                                              final isNumeric = int.tryParse(
                                                  value!); // Check if the entered value is an integer
                                              if (isNumeric == null) {
                                                return 'ادخل رقم صحيح';
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.text,
                                            labelText: "اضافه العدد"),
                                      ),
                                    ),
                                    (i != 0)
                                        ? InkWell(
                                            child: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              _removeField(i);
                                            },
                                          )
                                        : const SizedBox(
                                            width: 20,
                                          ),
                                  ],
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey[300],
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 800.w),
                      child: CustomButton(
                        onPressed: () {
                          String offer = offers.text;
                          if (offers.text.isEmpty) {
                            offer = "لا يوجد عروض";
                          }
                          //    print(timeinputTo.text);
                          devicesList = _items
                              .asMap()
                              .map((index, _) => MapEntry(
                                    index,
                                    {
                                      "name": _items[index].text.trim(),
                                      "number": _quantity[index].text.trim(),
                                    },
                                  ))
                              .values
                              .toList();
                          print(devicesList);
                          //   print(timeinputFrom.text);
                          print("-------------");
                          //    print(timeinputTo.text);
                          if (formKey.currentState != null &&
                              _formKey.currentState != null) {
                            if (formKey.currentState!.validate() &&
                                _formKey.currentState!.validate() &&
                                itemCubit.pickedLogo != null &&
                                itemCubit.pickedImage1 != null &&
                                itemCubit.pickedImage2 != null &&
                                itemCubit.pickedImage3 != null &&
                                (categoryName != null || categoryName != "") &&
                                statue != null &&
                                (formattedDate != null ||
                                    formattedDate != "")) {
                              itemCubit.AddItem(
                                  logo: itemCubit.pickedLogo,
                                  image1: itemCubit.pickedImage1,
                                  image2: itemCubit.pickedImage2,
                                  image3: itemCubit.pickedImage3,
                                  name: name.text,
                                  description: description.text,
                                  //  price: price.text,
                                  categoryName: categoryName,
                                  statues: statue.toString(),
                                  address: address.text,
                                  offers: offer,
                                  //  date: formattedDate,
                                  type: "قفلقف",
                                  collectibles: jsonEncode(devicesList));
                            } else {
                              showError("من فضلك ادخل القيم الناقصه");
                            }
                          }
                        },
                        text: "اضافه عنصر",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    )
                  ],
                ),
              )),
            );
          },
        );
      },
    );
  }
}
