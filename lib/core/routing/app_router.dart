import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/features/Add-Additional-Options/business-logic/additional_options_cubit/additional_options_cubit.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:reservationapp_admin/features/Add-Items/business-logic/Item_cubit/item_cubit.dart';
import 'package:reservationapp_admin/features/Auth/business-logic/auth-cubit/login_cubit.dart';
import 'package:reservationapp_admin/features/Edit-Item/presentation/edit-item.dart';
import 'package:reservationapp_admin/features/View-Additional-Options/presentation/view-additional-options-screen.dart';
import 'package:reservationapp_admin/features/View-Admins/business-logic/admin_cubit/admin_cubit.dart';
import 'package:reservationapp_admin/features/View-Admins/presentation/view-admin.dart';
import 'package:reservationapp_admin/features/View-Reservations/presentation/view-reservations.dart';
import 'package:reservationapp_admin/features/View-Waiting-Reservations/business-logic/reservations_cubit/reservations_cubit.dart';
import 'package:reservationapp_admin/features/View-Waiting-Reservations/presentation/view-waiting-reservations.dart';
import 'package:reservationapp_admin/features/View-categories/presentation/view_categories_screen.dart';
import 'package:reservationapp_admin/features/View-category-details/business-logic/category_cubit/category_items_cubit.dart';
import 'package:reservationapp_admin/features/View-category-details/presentation/view-category-details.dart';
import 'package:reservationapp_admin/features/View-receptionist/business-logic/receptionist_cubit/receptionist_cubit.dart';
import 'package:reservationapp_admin/features/View-receptionist/presentation/view-receptionist.dart';
import 'package:reservationapp_admin/features/View-users/business-logic/accept-user/cubit.dart';
import 'package:reservationapp_admin/features/View-users/business-logic/users_cubit/users_cubit.dart';
import 'package:reservationapp_admin/features/View-users/presentation/view-user.dart';
import 'package:reservationapp_admin/features/home/business-logic/cubit/mainlayout_cubit.dart';

import '../../features/Add-Items/presentation/add-item.dart';
import '../../features/Auth/presentation/login-screen.dart';
import '../../features/View-category-details/data/models/items-model.dart';
import '../../features/home/presentation/home.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )

    switch (settings.name) {
      case Routes.viewReservationsScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => ReservationsCubit()..getReservations(),
            child: const ViewReservationscreen(),
          ),
        );
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
      case Routes.viewAdminScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => AdminCubit()..getadmins(),
            child: const ViewAdminsScreen(),
          ),
        );
      case Routes.addItemScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CategoryCubit()..getCategories(),
              ),
              BlocProvider(
                create: (context) => ItemCubit(),
              ),
            ],
            child: const AddItemScreen(),
          ),
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

      case Routes.viewWatiningReservationsScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => ReservationsCubit()..getReservations(),
            child: ViewWaitingReservationscreen(),
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
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CategoryItemsCubit(),
              ),
              BlocProvider(
                create: (context) => ItemCubit(),
              ),
            ],
            child: ViewCategoryDetails(
              title: categoryName,
            ),
          ),
        );

      case Routes.mainlayout:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            settings: settings,
            child: BlocProvider(
              create: (context) => MainlayoutCubit(),
              child: const Home(),
            ));
      case Routes.editItemScreen:
        final item = settings.arguments as Data;
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            settings: settings,
            child: BlocProvider(
              create: (context) => ItemCubit(),
              child: EditItemScreen(
                item: item,
              ),
            ));
      case Routes.viewCategoriesScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => CategoryCubit()..getCategories(),
            child: const ViewCategoriesScreen(),
          ),
        );

      case Routes.viewAdditionalOptionsScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) =>
                AdditionalOptionsCubit()..getAllAdditionalOptions(),
            child: const ViewAdditionalOptionsScreen(),
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
