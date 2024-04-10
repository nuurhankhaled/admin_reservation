import 'dart:convert';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/features/Dashboard/presentation/widgets/charts_widget.dart';
import 'package:reservationapp_admin/features/Dashboard/presentation/widgets/dashboard_chart.dart';
import 'package:reservationapp_admin/features/Dashboard/presentation/widgets/dashboard_circle_chart.dart';
import 'package:reservationapp_admin/features/Dashboard/presentation/widgets/dashboard_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Core/Api/endPoints.dart';
import '../../../core/Api/my_http.dart';
import '../../../core/theming/colors.dart';
import '../../View-Waiting-Reservations/data/models/reservations-model.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  Map<dynamic,dynamic> values = {"accept" : 0 , "wait" : 0 , "percent" : 0} ;
  Map<dynamic,dynamic> reservationStatistics = {} ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReservations().then((value) {
      values = value[0] ;
      reservationStatistics = value[1] ;
      setState(() {

      });
    });
  }

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
                  chartWidget: MainLayoutChart(
                    map: reservationStatistics
                  ),
                ),
                SizedBox(
                  width: 120.w,
                ),
                CircleChart(
                  head: 'نسبة الحجوزات المقبولة الي الغير مقبولة',
                  percent: double.parse("${values["percent"]!.toStringAsFixed(1)}") ,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<dynamic,dynamic>>> getReservations() async {
    Map<dynamic,dynamic> reservationStatistics = {};
    Map<dynamic,dynamic> values = {"accept" : 0 , "wait" : 0 , "percent" : 0} ;
    var response = await MyDio.get(endPoint: EndPoints.getReservations);
    print(response!.statusCode);
    if (response.statusCode == 200) {
      print(">->-): "+response.data);
      var decodedData = json.decode(response.data);
      var jsonResponse = ReservationsModel.fromJson(decodedData);
      if (jsonResponse.success!) {
        for (var reservation in jsonResponse.data!) {
          if(reservationStatistics[reservation.item?.name] == null)
            reservationStatistics.addAll({reservation.item?.name : 1});
          else
            reservationStatistics[reservation.item?.name]++;

          if (reservation.status == "0") {
            values["wait"] = double.parse("${values["wait"]}") + 1;
            print("): ${values["wait"]}");
          } else {
            values["accept"] = double.parse("${values["accept"]}") + 1;
            print("): ${values["accept"]}");
          }
        }
      }
    }

    values["percent"] = (double.parse(values["accept"].toString()) / (double.parse(values["wait"].toString()) + double.parse(values["accept"].toString()))) ;

    return [values , reservationStatistics] ;
  }
}
