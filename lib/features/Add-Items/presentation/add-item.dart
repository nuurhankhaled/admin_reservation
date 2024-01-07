import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/widgets/custom_button.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:reservationapp_admin/features/Add-Items/presentation/add-fields-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItem extends StatefulWidget {
  AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  List<String> _statues = ["في الصيانه", "محجوز", "متاح"];

  List<String> _priceState = ["خلال اليوم", "خلال الساعه"];

  String startTime = 'from';

  String endTime = 'to';

  String? categoryId;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addField();
    });
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    //FormData formData = FormData.fromMap({});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var categoryCubit = CategoryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("اضافه عنصر"),
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
              Padding(
                padding: EdgeInsets.only(left: 150, top: 10.h),
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
                        hint: Text("المنشأه",
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
                          categoryId = categoryCubit.categories[value!].id!;
                          setState(() {
                            categoryId = categoryCubit.categories[value].id!;
                            print(" city id : $categoryId");
                          });
                          ;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
                              image: const DecorationImage(
                                image: AssetImage("assets/images/loggo.png"),
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
                                    onPressed: () {},
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
                              image: const DecorationImage(
                                image: AssetImage("assets/images/loggo.png"),
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
                                    onPressed: () {},
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
                              image: const DecorationImage(
                                image: AssetImage("assets/images/loggo.png"),
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
                                    onPressed: () {},
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
                              image: const DecorationImage(
                                image: AssetImage("assets/images/loggo.png"),
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
                                    onPressed: () {},
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
                                    backgroundColor: Colors.grey[300],
                                    padding: EdgeInsets.only(
                                        bottom: 22.h, left: 10.w, right: 10.w),
                                    height: 80.h,
                                  ),
                                ),
                              ),
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
                                        width: 100.w,
                                        child: Text(_statues[index]),
                                      ));
                                },
                              ),
                              onChanged: (int? value) {
                                // areaId =
                                // cubit.cityAreas[value!].id!;
                                // setState(() {
                                //   areaId =
                                //   cubit.cityAreas[value!].id!;
                                // });
                                // print(" area id : $areaId");
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
                              items: List.generate(
                                _priceState.length,
                                (index) {
                                  return DropdownMenuItem<int>(
                                      value: index,
                                      child: Container(
                                        width: 100.w,
                                        child: Text(_priceState[index]),
                                      ));
                                },
                              ),
                              onChanged: (int? value) {
                                // areaId =
                                // cubit.cityAreas[value!].id!;
                                // setState(() {
                                //   areaId =
                                //   cubit.cityAreas[value!].id!;
                                // });
                                // print(" area id : $areaId");
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
                padding: EdgeInsets.only(right: 100.w),
                child: Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      _addField();
                    },
                    child: const Icon(
                      Icons.add_circle,
                      size: 30,
                    ),
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
                                      child: const Icon(Icons.remove_circle),
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
                child: const CustomButton(
                  text: "اضافه عنصر",
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
