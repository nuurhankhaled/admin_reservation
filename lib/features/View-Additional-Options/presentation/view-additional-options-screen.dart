import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Additional-Options/business-logic/additional_options_cubit/additional_options_cubit.dart';
import 'package:reservationapp_admin/features/View-Additional-Options/data/models/additional-options-model.dart';
import 'package:reservationapp_admin/features/View-Additional-Options/presentation/widgets/edit-option-dialpog.dart';

class ViewAdditionalOptionsScreen extends StatelessWidget {
  const ViewAdditionalOptionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var categoryController = TextEditingController();
    var cubit = AdditionalOptionsCubit.get(context);

    return BlocConsumer<AdditionalOptionsCubit, AdditionalOptionsState>(
      listener: (context, state) {
        if (state is DeleteAdditionalOptionsSuccess) {
          AdditionalOptionsCubit.get(context).getAllAdditionalOptions();
        }
      },
      builder: (context, state) {
        List<Data> filteredList = [];
        if (searchController.text.isEmpty && categoryController.text.isEmpty) {
          filteredList = cubit.additionalOptions;
        } else {
          filteredList = cubit.additionalOptions
              .where((time) => (time.itemName != null)
                  ? (categoryController.text.trim() != "")
                      ? (searchController.text.trim() != "")
                          ? time.itemName!.toLowerCase().contains(
                                  searchController.text.toLowerCase()) &&
                              time.category!.name!
                                  .toLowerCase()
                                  .contains(categoryController.text)
                          : time.category!.name!
                              .toLowerCase()
                              .contains(categoryController.text)
                      : time.itemName!
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())
                  : false)
              .toList();
        }

        return Scaffold(
            appBar: AppBar(
              title: const Text('عرض الاضافات ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
                      controller: categoryController,
                      onChanged: (value) {
                        context
                            .read<AdditionalOptionsCubit>()
                            .getAllAdditionalOptions();
                      },
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      hintText: 'ابحث عن منشأه...',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 10),
                  child: SizedBox(
                    width: 200,
                    child: CustomTextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        context
                            .read<AdditionalOptionsCubit>()
                            .getAllAdditionalOptions();
                      },
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      hintText: 'ابحث عن وحدة...',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
            body: (state is GetAdditionalOptionsLoading)
                ? const CustomLoadingIndicator()
                : (cubit.additionalOptions.isEmpty)
                    ? const Center(
                        child: Text("لايوجد اغراض للعرض",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800)),
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
                                  DataColumn(label: Text("المنشأه")),
                                  DataColumn(label: Text("اسم الوحده")),
                                  DataColumn(label: Text('الاسم')),
                                  DataColumn(label: Text('السعر')),
                                  DataColumn(label: Text('تعديل')),
                                  DataColumn(label: Text('مسح')),
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

                                        if (filteredList.indexOf(user) % 2 ==
                                            0) {
                                          return Colors.grey[100];
                                        }
                                        return null;
                                      },
                                    ),
                                    cells: [
                                      DataCell(Text((user.category != null)
                                          ? user.category!.name!
                                          : "تم الحذف")),
                                      DataCell(Text((user.itemName != null)
                                          ? user.itemName!
                                          : "تم الحذف")),
                                      DataCell(Text(user.name!)),
                                      DataCell(Text(user.price!)),
                                      DataCell(IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return BlocProvider(
                                                create: (context) =>
                                                    AdditionalOptionsCubit(),
                                                child:
                                                    EditAdditionalOptionsDialog(
                                                        id: user.id.toString(),
                                                        name: user.name!,
                                                        price: user.price!),
                                              );
                                            },
                                          );
                                        },
                                      )),
                                      DataCell(
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            cubit.deleteAdditionalOption(
                                                id: user.id.toString());
                                          },
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
