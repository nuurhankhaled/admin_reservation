import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/theming/colors.dart';

class ViewPersonScreen extends StatelessWidget {
  ViewPersonScreen({super.key});
  List userList = [
    {
      "code": 1,
      "name": "ahmed",
      "email": "allo",
      "phone": 123456789,
      "accepted": true
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('View Person'),
            leading: Padding(
              padding: EdgeInsets.only(right: 50.w),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => context.pop(),
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
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
                  columns: [
                    DataColumn(label: Text("الكود")),
                    DataColumn(label: Text("الاسم")),
                    DataColumn(label: Text('البريد الالكتروني')),
                    DataColumn(label: Text('رقم الهاتف')),
                    DataColumn(label: Text('الحاله')),
                  ],
                  rows: userList.map((user) {
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          // All rows will have the same selected color.
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.08);
                          }
                          // Even rows will have a grey color.
                          if (userList.indexOf(user) % 2 == 0) {
                            return Colors.grey.withOpacity(0.3);
                          }
                          return null; // Use default value for other states and odd rows.
                        },
                      ),
                      cells: [
                        DataCell(Text(user.code.toString())),
                        DataCell(Text(user.name)),
                        DataCell(Text(user.email)),
                        DataCell(Text(user.phone.toString())),
                        DataCell(Text(user.accepted.toString())),
                        DataCell(
                          Checkbox(
                            value: user.accepted,
                            onChanged: (value) {
                              if (value == true) {
                                // context
                                //     .read<UserListCubit>()
                                //     .acceptUser(userList.indexOf(user));
                              } else if (value == false) {
                                // context
                                //     .read<UserListCubit>()
                                //     .rejectUser(userList.indexOf(user));
                              }
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
  }
}
