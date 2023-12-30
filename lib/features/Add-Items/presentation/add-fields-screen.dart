import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/widgets/custom_button.dart';

class AddFieldsScreen extends StatefulWidget {
  const AddFieldsScreen({super.key});

  @override
  State<AddFieldsScreen> createState() => _AddFieldsScreenState();
}

class _AddFieldsScreenState extends State<AddFieldsScreen> {
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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    _addField();
                  },
                  child: const Icon(Icons.add_circle),
                ),
              ),
              SizedBox(
                height: 10.h,
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
                                  child: TextFormField(
                                    controller: _items[i],
                                    validator: (value) {
                                      if (value == "") {
                                        return "please enter empty fields";
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        label: const Text("اضافه مقتنيه")),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(38.sp),
                                child: Container(
                                  width: 100,
                                  child: TextFormField(
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
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        label: const Text("اضافه العدد")),
                                  ),
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
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(width: 200, text: "اضافه المقتنيات"),
                  SizedBox(
                    width: 20,
                  ),
                  CustomButton(width: 200, text: "اضافه المقتنيات"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
