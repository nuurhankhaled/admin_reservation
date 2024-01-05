import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:reservationapp_admin/features/Add-Items/presentation/add-item.dart';
import 'package:reservationapp_admin/features/Auth/business-logic/auth-cubit/login_cubit.dart';
import 'package:reservationapp_admin/features/View-category-details/business-logic/category_cubit/category_items_cubit.dart';
import 'package:reservationapp_admin/features/View-category-details/presentation/view-category-details.dart';
import 'package:reservationapp_admin/features/View-categories/presentation/view-categories-screen.dart';
import 'package:reservationapp_admin/features/View-receptionist/business-logic/receptionist_cubit/receptionist_cubit.dart';
import 'package:reservationapp_admin/features/View-receptionist/presentation/view-receptionist.dart';
import 'package:reservationapp_admin/features/View-users/business-logic/accept-user/cubit.dart';
import 'package:reservationapp_admin/features/View-users/business-logic/users_cubit/users_cubit.dart';
import 'package:reservationapp_admin/features/View-users/presentation/view-user.dart';
import 'package:reservationapp_admin/features/home/business-logic/cubit/mainlayout_cubit.dart';
import '../../features/Auth/presentation/login-screen.dart';
import '../../features/home/presentation/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )

    switch (settings.name) {
      case Routes.authScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => AuthCubit(),
            child: AuthScreen(),
          ),
        );

      case Routes.addItemScren:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: AddItem(),
        );

      case Routes.viewReceptionistScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => ReceptionistCubit()..getReceptionists(),
            child: ViewReceptionistScreen(),
          ),
        );

      case Routes.viewUsersScreen:
        final isAccepted = settings.arguments as int;
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UsersCubit()
                    ..getAcceptedUsers()
                    ..getPendingUsers(),
                ),
                BlocProvider(
                  create: (context) => AcceptUserCubit(),
                ),
              ],
              child: ViewUsersScreen(
                isAccepted: isAccepted,
              )),
        );

      case Routes.viewCategoryDetailsScreen:
        final categoryName = settings.arguments as String;
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => CategoryItemsCubit(),
            child: ViewCategoryDetails(
              title: categoryName,
            ),
          ),
        );
      //       settings: settings,
      //       child: EditProfileScreen()
      //   );
      //
      // case Routes.walletScreen:
      //   return PageTransition(
      //     type: PageTransitionType.fade,
      //     duration: const Duration(milliseconds: 200),
      //     alignment: Alignment.center,
      //     settings: settings,
      //     child: WalletScreen()
      //   );
      //
      // case Routes.tripsHistoryScreen:
      //   return PageTransition(
      //       type: PageTransitionType.fade,
      //       duration: const Duration(milliseconds: 200),
      //       alignment: Alignment.center,
      //       settings: settings,
      //       child: TripsHistory(),
      //   );
      //
      // case Routes.settingsScreen:
      //   return PageTransition(
      //     type: PageTransitionType.fade,
      //     duration: const Duration(milliseconds: 200),
      //     alignment: Alignment.center,
      //     settings: settings,
      //     child: SettingsScreen()
      //   );
      //
      // case Routes.mapScreen:
      //   return PageTransition(
      //       type: PageTransitionType.fade,
      //       duration: const Duration(milliseconds: 200),
      //       alignment: Alignment.center,
      //       settings: settings,
      //       child: MapScreen()
      //   );
      //
      case Routes.mainlayout:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            settings: settings,
            child: BlocProvider(
              create: (context) => MainlayoutCubit(),
              child: Home(),
            ));

      case Routes.viewCategoriesScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => CategoryCubit()..getCategories(),
            child: ViewCategoriesScreen(),
          ),
        );

      default:
        return PageTransition(
          child: Scaffold(
            body: Text("No route found for ${settings.name}"),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
        );
    }
  }
}
