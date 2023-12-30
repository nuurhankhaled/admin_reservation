import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/features/Add-Items/presentation/add-item.dart';
import 'package:reservationapp_admin/features/Auth/business-logic/auth-cubit/login_cubit.dart';
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

      case Routes.addItem:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
          child: AddItem(),
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
