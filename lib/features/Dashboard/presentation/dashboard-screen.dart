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
      padding: EdgeInsets.all(20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                SummaryCard(
                  containerColor: Colors.blueGrey,
                  textName: 'المحاسبين',
                  icon: Icons.account_balance_outlined,
                  textTotalNumber: '200',
                ),
                SummaryCard(
                  containerColor: AppColors.primaryColor,
                  textName: 'المستخدمين',
                  icon: Icons.people_outline,
                  textTotalNumber: '500',
                ),
                SummaryCard(
                  containerColor: AppColors.buttonBackGroundColor,
                  textName: 'التقارير',
                  icon: Icons.analytics_outlined,
                  textTotalNumber: '12',
                ),
                SummaryCard(
                  containerColor: AppColors.greyColor,
                  textName: 'الأجمالي',
                  icon: Icons.money,
                  textTotalNumber: '150',
                ),
              ],
            ),
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
