import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/features/Dashboard/presentation/widgets/charts_widget.dart';
import 'package:reservationapp_admin/features/Dashboard/presentation/widgets/dashboard_chart.dart';
import 'package:reservationapp_admin/features/Dashboard/presentation/widgets/dashboard_circle_chart.dart';
import 'package:reservationapp_admin/features/Dashboard/presentation/widgets/dashboard_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theming/colors.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Padding(
      padding: EdgeInsets.all(5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              SummaryCard(
                containerColor: Colors.blueGrey,
                textName: 'موظفين الاستقبال',
                icon: Icons.account_balance_outlined,
                onTap: () => context.pushNamed(Routes.viewReceptionistScreen),
              ),
              SummaryCard(
                containerColor: AppColors.primaryColor,
                textName: 'المستخدمين',
                icon: Icons.people_outline,
                onTap: () =>
                    context.pushNamed(Routes.viewUsersScreen, arguments: 1),
              ),
              SummaryCard(
                containerColor: AppColors.buttonBackGroundColor,
                textName: 'المنشآت',
                icon: Icons.analytics_outlined,
                onTap: () => context.pushNamed(Routes.viewCategoriesScreen),
              ),
              SummaryCard(
                containerColor: AppColors.greyColor,
                textName: 'المستخدمين المعلقين',
                icon: Icons.person_2_outlined,
                onTap: () =>
                    context.pushNamed(Routes.viewUsersScreen, arguments: 0),
              ),
            ],
          ),
          SizedBox(
            height: 80.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                ChartsConatiner(
                  chartWidget: MainLayoutChart(),
                ),
                SizedBox(
                  width: 120.w,
                ),
                CircleChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
