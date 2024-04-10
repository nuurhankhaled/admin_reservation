import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/bloc_observer.dart';
import 'package:reservationapp_admin/core/cache_helper/cache_helper.dart';
import 'package:reservationapp_admin/core/cache_helper/cache_values.dart';
import 'package:window_manager/window_manager.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  Bloc.observer = MyBlocObserver();
  MyDio.init();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1400, 750), // Use a default size
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: "احجز-الادمن",
    windowButtonVisibility: true,
    maximumSize: Size(1400, 780),
    minimumSize: Size(1350, 740),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.isResizable();
    await windowManager.isMovable();
    await windowManager.center();
  });

  runApp(
    EasyLocalization(
      path: "assets/languages",
      supportedLocales: const [
        Locale("en", "UK"),
        Locale("ar", "EG"),
      ],
      fallbackLocale: const Locale("ar", "EG"),
      child: MyApp(
        appRouter: AppRouter(),
      )
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          builder: EasyLoading.init(),
          initialRoute: (CacheHelper.getData(key: CacheKeys.userToken) != null)
              ? Routes.authScreen
              : Routes.mainlayout,
        ),
      ),
    );
  }
}
