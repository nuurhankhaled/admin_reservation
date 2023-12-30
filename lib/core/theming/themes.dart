import 'package:colorfilter_generator/addons.dart';
import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: Color(0xffFAF8F1),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
  ),
  scaffoldBackgroundColor: const Color(0xffFAF8F1),
  primaryColor: Colors.black,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(background: Colors.white),
);

final ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0,
    scrolledUnderElevation: 0,
    color: AppColors.primaryColor,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xff151C27),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey[600],
  ),
  scaffoldBackgroundColor: const Color(0xff151C27),
  primaryColor: const Color(0xff151C27),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(background: const Color(0xff151C27)),
);

ColorFilterGenerator darkModeFilter = ColorFilterGenerator(
    name: "Dark Mode OSM",
    filters: [ColorFilterAddons.grayscale(), ColorFilterAddons.invert()]);

ColorFilterGenerator lightModeFilter = ColorFilterGenerator(
    name: "Light Mode OSM",
    filters: [ColorFilterAddons.saturation(-0.4),ColorFilterAddons.sepia(-0.5)]);