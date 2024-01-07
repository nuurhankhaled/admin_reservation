import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/features/Add-Additional-Options/business-logic/additional_options_cubit/additional_options_cubit.dart';
import 'package:reservationapp_admin/features/Add-Additional-Options/presenatation/add-additional-options-screen.dart';
import 'package:reservationapp_admin/features/Add-Cashier/business-logic/add-chashier/cubit.dart';
import 'package:reservationapp_admin/features/Add-Cashier/presentation/add-cashier-dialoge.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:reservationapp_admin/features/Add-Category/presentation/add-facility-dialoge.dart';
import 'package:reservationapp_admin/features/Add-admin/business-logic/add-chashier/cubit.dart';
import 'package:reservationapp_admin/features/Add-admin/presentation/add-cashier-dialoge.dart';
import 'package:reservationapp_admin/features/Dashboard/presentation/dashboard-screen.dart';
import 'package:reservationapp_admin/features/home/business-logic/cubit/mainlayout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainlayoutCubit, MainlayoutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var mainlayoutCubit = MainlayoutCubit.get(context);
        return AdminScaffold(
          appBar: AppBar(title: Text("reservationApp".tr())),
          sideBar: SideBar(
            items: [
              AdminMenuItem(
                title: 'dashboard'.tr(),
                route: '/dashboard',
                icon: Icons.dashboard,
              ),
              AdminMenuItem(
                title: 'addAFacility'.tr(),
                route: '/addFacility',
                icon: Icons.home_work_sharp,
              ),
              AdminMenuItem(
                icon: Icons.add_business_rounded,
                title: "اضافه عنصر للمنشأه",
                route: '/addItem',
              ),
              AdminMenuItem(
                icon: Icons.add_business_rounded,
                title: 'addExtras'.tr(),
                route: '/addExtras',
              ),
              AdminMenuItem(
                icon: Icons.calculate_rounded,
                title: 'addCashier'.tr(),
                route: "/addCashier",
              ),
              AdminMenuItem(
                icon: Icons.person,
                title: 'اضافه ادمن',
                route: "/addAdmin",
              ),
              AdminMenuItem(
                icon: Icons.receipt_long_rounded,
                title: 'عرض الحجوزات',
                route: "/viewReservations",
              ),
              AdminMenuItem(
                icon: Icons.receipt,
                title: 'عرض الاضافات',
                route: "/viewExtras",
              ),
            ],
            selectedRoute: "/dashboard",
            onSelected: (item) {
              if (item.route != null) {
                mainlayoutCubit.changeSelectedItem(item.route!);
                print(mainlayoutCubit.selectedItem);
                switch (item.route) {
                  case "/addCashier":
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => AddCashierCubit(),
                            child: AddCashierDialoge(),
                          );
                        });
                    break;
                  case "/addItem":
                    context.pushNamed(Routes.addItemScren);
                    break;
                  case "/viewExtras":
                    context.pushNamed(Routes.viewAdditionalOptionsScreen);
                    break;
                  case "/viewReservations":
                    context.pushNamed(Routes.viewReservationsScreen);
                    break;
                  case "/addFacility":
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => CategoryCubit(),
                            child: AddCategoryDialog(),
                          );
                        });
                    break;
                  case "/addExtras":
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => AdditionalOptionsCubit(),
                            child: AddAdditionalOptionsDialog(),
                          );
                        });
                    break;
                  case "/addAdmin":
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => AddAdminCubit(),
                            child: AddAdminDialoge(),
                          );
                        });
                    break;
                  default:
                    print('Route not handled: ${item.route}');
                    break;
                }
              }
            },
            header: Container(
                height: 90.h,
                width: double.infinity,
                color: const Color(0xff444444),
                child: Center(
                  child: Text("details".tr(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )),
            footer: Container(
              height: 90.h,
              width: double.infinity,
              color: const Color(0xff444444),
              child: Center(
                  child: Text(
                "signOut".tr(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                DashBoardScreen(),
              ],
            ),
          )),
        );
      },
    );
  }
}
