import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/core/widgets/custom_button.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:reservationapp_admin/features/View-category-details/data/models/items-model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reservationapp_admin/features/Add-Items/business-logic/Item_cubit/item_cubit.dart';

class EditItemScreen extends StatefulWidget {
  Data item;
  EditItemScreen({super.key, required this.item});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  List<String> _statues = ["في الصيانه", "متاح", "محجوز"];
  List<String> _priceState = ["خلال اليوم", "خلال الساعه"];

  File? pickedLogo; // Variable to store the selected image
  File? pickedImage1; // Variable to store the selected image
  File? pickedImage2; // Variable to store the selected image
  File? pickedImage3; // Variable to store the selected image

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController offers = TextEditingController();
  TextEditingController timeinputFrom = TextEditingController();
  TextEditingController timeinputTo = TextEditingController();

  String? categoryName;
  int? statue;
  String? priceDuaration;

  final List<TextEditingController> _items = [TextEditingController()];
  final List<TextEditingController> _quantity = [TextEditingController()];

  final _formKey = GlobalKey<FormState>();

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

  void initializeListsFromData() {
    String devicesData = widget.item.devices ?? '[]';

    List<Map<String, dynamic>> decodedDevices = [];

    try {
      decodedDevices = List<Map<String, dynamic>>.from(
        jsonDecode(devicesData),
      );
    } catch (e) {
      print('Error decoding devices data: $e');
    }

    _items.clear();
    _quantity.clear();

    for (var device in decodedDevices) {
      String name = device['name'] ?? '';
      String number = device['number'] ?? '';

      // Check if both name and number are not empty before adding to the lists
      if (name.isNotEmpty && number.isNotEmpty) {
        _items.add(TextEditingController(text: name));
        _quantity.add(TextEditingController(text: number));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addField();
    });
    initializeListsFromData();
    categoryName = widget.item.categoryName;
    print(categoryName);
    timeinputFrom.text =
        widget.item.availableTimeFrom!; //set the initial value of text field
    timeinputTo.text = widget.item.availableTimeTo!;
    name.text = widget.item.name!; //set the initial value of text field
    description.text =
        widget.item.description!; //set the initial value of text field
    address.text = widget.item.address!; //set the initial value of text field
    price.text = widget.item.price!; //set the initial value of text field
    offers.text = widget.item.offer!;
    statue = int.parse(widget.item.status!);
    priceDuaration = widget.item.type!;
  }

  String formatItemList() {
    String result = '';
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].text.isNotEmpty && _quantity[i].text.isNotEmpty) {
        String formattedItem =
            ' ${_items[i].text.trim()} ${_quantity[i].text} عدد';
        result += formattedItem;

        // Add "/" if it's not the last item
        if (i < _items.length - 1) {
          result += ' / ';
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemCubit, ItemState>(
      listener: (context, state) {
        if (state is EditItemSuccess) {
          context.pop();
          context.pushReplacementNamed(Routes.viewCategoryDetailsScreen,
              arguments: widget.item.categoryName!);
        }
      },
      builder: (context, state) {
        var itemCubit = ItemCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "تعديل عنصر",
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
          ),
          body: SingleChildScrollView(
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
                                      image: FileImage(itemCubit.pickedLogo!),
                                      fit: BoxFit.contain,
                                    )
                                  : DecorationImage(
                                      image: NetworkImage(widget.item.logo!),
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
                                          width: 7.w, color: Colors.white)),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 30.w,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      itemCubit.pickLogo(
                                          ImageSource.gallery, context);
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
                                      image: FileImage(itemCubit.pickedImage1!),
                                      fit: BoxFit.contain,
                                    )
                                  : DecorationImage(
                                      image: NetworkImage(widget.item.image1!),
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
                                          width: 7.w, color: Colors.white)),
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
                                      image: FileImage(itemCubit.pickedImage2!),
                                      fit: BoxFit.contain,
                                    )
                                  : DecorationImage(
                                      image: NetworkImage(widget.item.image2!),
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
                                          width: 7.w, color: Colors.white)),
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
                                      image: FileImage(itemCubit.pickedImage3!),
                                      fit: BoxFit.contain,
                                    )
                                  : DecorationImage(
                                      image: NetworkImage(widget.item.image3!),
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
                                          width: 7.w, color: Colors.white)),
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
                        child: Container(
                          width: 420.w,
                          child: CustomTextFormField(
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
                        child: Container(
                          width: 420.w,
                          child: CustomTextFormField(
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
                          "التوقيت",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70.w),
                                child: const Text(
                                  " من صباحا",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.w, vertical: 40.h),
                                child: Container(
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
                                    prefixIcon: Padding(
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
                                padding: EdgeInsets.symmetric(horizontal: 70.w),
                                child: const Text(
                                  " الي مساءا",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.w, vertical: 40.h),
                                child: Container(
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
                                          DateTime(2024, 1, 1, pickedTime.hour,
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
                                    prefixIcon: Padding(
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
                                      child: Container(
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
                        child: Container(
                          width: 420.w,
                          child: CustomTextFormField(
                            controller: address,
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
                          "السعر",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.w, vertical: 40.h),
                        child: Container(
                          width: 420.w,
                          child: CustomTextFormField(
                            controller: price,
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
                        child: Container(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70.w),
                        child: const Text(
                          "السعر / الفتره",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.w, vertical: 20.h),
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
                                "اختر الفترة",
                                style: TextStyle(color: Colors.black),
                              ),
                              value: (widget.item.type == "خلال اليوم") ? 0 : 1,
                              items: List.generate(
                                _priceState.length,
                                (index) {
                                  return DropdownMenuItem<int>(
                                      value: index,
                                      child: Container(
                                        width: 140.w,
                                        child: Text(_priceState[index]),
                                      ));
                                },
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  priceDuaration = _priceState[value!];
                                });
                                print('priceDuaration : $priceDuaration');
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
                    for (int i = 0; i < _items.length - 1; i++)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          return "please enter empty fields";
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      labelText: "اضافه مقتنيه"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(38.sp),
                                child: Container(
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
                                      },
                                      keyboardType: TextInputType.text,
                                      labelText: "اضافه العدد"),
                                ),
                              ),
                              (i != 0)
                                  ? InkWell(
                                      child: Icon(
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
                    print(timeinputTo.text);
                    var devicesList = _items
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
                    itemCubit.editItem(
                        id: widget.item.id!,
                        logo: itemCubit.editedLogo ?? "",
                        image1: itemCubit.editedImage1 ?? "",
                        image2: itemCubit.editedImage2 ?? "",
                        image3: itemCubit.editedImage3 ?? "",
                        name: name.text,
                        description: description.text,
                        price: price.text,
                        availableTimeFrom: timeinputFrom.text,
                        availableTimeTo: timeinputTo.text,
                        categoryName: categoryName,
                        statues: statue.toString(),
                        address: address.text,
                        offers: offer,
                        type: priceDuaration,
                        collectibles: jsonEncode(devicesList));
                  },
                  text: "تعديل عنصر",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          )),
        );
      },
    );
  }
}
