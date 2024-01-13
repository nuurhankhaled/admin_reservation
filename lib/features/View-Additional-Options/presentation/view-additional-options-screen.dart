import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/features/Add-Additional-Options/business-logic/additional_options_cubit/additional_options_cubit.dart';
import 'package:reservationapp_admin/features/View-Additional-Options/presentation/widgets/edit-option-dialpog.dart';
import 'package:reservationapp_admin/features/View-receptionist/business-logic/receptionist_cubit/receptionist_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAdditionalOptionsScreen extends StatelessWidget {
  ViewAdditionalOptionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = AdditionalOptionsCubit.get(context);

    return BlocConsumer<AdditionalOptionsCubit, AdditionalOptionsState>(
      listener: (context, state) {
        if (state is DeleteAdditionalOptionsSuccess) {
          cubit.getAllAdditionalOptions();
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
                title: Text('عرض الاضافات ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Padding(
                  padding: EdgeInsets.only(right: 50.w),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => context.pop(),
                  ),
                )),
            body: (state is GetAdditionalOptionsLoading)
                ? CustomLoadingIndicator()
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
                                  DataColumn(label: Text("الكود")),
                                  DataColumn(label: Text("كود العنصر")),
                                  DataColumn(label: Text("اسم العنصر")),
                                  DataColumn(label: Text('الاسم')),
                                  DataColumn(label: Text('السعر')),
                                  DataColumn(label: Text('تعديل')),
                                  DataColumn(label: Text('مسح')),
                                ],
                                rows: cubit.additionalOptions.map((user) {
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
                                        if (cubit.additionalOptions
                                                    .indexOf(user) %
                                                2 ==
                                            0) {
                                          return Colors.grey[100];
                                        }
                                        return null; // Use default value for other states and odd rows.
                                      },
                                    ),
                                    cells: [
                                      DataCell(Text(user.id.toString())),
                                      DataCell(Text(user.itemId!)),
                                      DataCell(Text(user.itemName!)),
                                      DataCell(Text(user.name!)),
                                      DataCell(Text(user.price!)),
                                      DataCell(IconButton(
                                        icon: Icon(
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
                                          icon: Icon(
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
