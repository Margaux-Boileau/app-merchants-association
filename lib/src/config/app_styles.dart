import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Aquí irán los estilos principales de la app
/// FontFamily, Colors, appbars, navigations...

class AppStyles {
  static final mainTheme = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: textTheme.apply(fontFamily: 'Poppins'),

    /// AppBar Theme
    appBarTheme: AppBarTheme(
      // Color de fons de l'Appbar
      backgroundColor: AppColors.primaryBlue,
      // Color que s'aplica per sobre del backgroundColor per indicar la elevation
      // quan s'ha fet scroll.
      // Si és null, no s'aplica.
      surfaceTintColor: AppColors.surface,

      // Color de l'obra de l'elevation.
      shadowColor: AppColors.black,

      // Elevation de l'AppBar si no s'ha fet scroll al contingut.
      elevation: 0.0,

      // Elevation de l'AppBar si s'ha fet scroll al contingut.
      scrolledUnderElevation: 0.0,
      centerTitle: false,
      titleSpacing: 0.0,
      titleTextStyle: textTheme.headlineLarge!
          .copyWith(color: AppColors.background, fontFamily: 'Poppins'),
    ),

    /// Navigation Bar Theme
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.primaryBlue,
      surfaceTintColor: AppColors.primaryBlue,
      indicatorColor: AppColors.white,
      iconTheme: MaterialStateProperty.all(
        IconThemeData(
          color: AppColors.white,
          //size: 24.0,
        ),
      ),
    ),

    /// TabBarTheme
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.black,
      labelStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelColor: AppColors.appGrey,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        insets: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        borderSide: BorderSide(
          color: AppColors.black,
          width: 3.0,
        ),
      ),
    ),

    /// ElevatedButtonTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        //elevation: MaterialStateProperty.all(4.0),
        elevation: MaterialStateProperty.resolveWith<double>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return 0.0;
            }
            return 0.0;
          },
        ),
        textStyle: MaterialStateProperty.all(textTheme.labelLarge),
        foregroundColor: MaterialStateProperty.all(AppColors.white),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.primaryBlue.withOpacity(0.5);
            }
            return AppColors.primaryBlue;
          },
        ),
      ),
    ),

    /// TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        foregroundColor: AppColors.black,
        textStyle: const TextStyle(
          fontFamily: 'Mulish',
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    /// Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.black,
      ),
    ),

    /// Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      // fillColor: MaterialStateProperty.all(AppColors.secondary),
      side: const BorderSide(
        width: 1.0,
      ),
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.appDarkGrey;
          } else if (states.contains(MaterialState.selected)) {
            return AppColors.black;
          }
          return AppColors.black;
        },
      ),
    ),

    /// Input decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      errorMaxLines: 3,
      helperMaxLines: 3,
      floatingLabelStyle:
          MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return textTheme.bodySmall!.copyWith(color: AppColors.primaryBlue);
        }
        return textTheme.bodySmall!.copyWith(color: AppColors.outline);
      }),
      labelStyle: MaterialStateTextStyle.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return textTheme.bodyMedium!.copyWith(color: AppColors.primaryBlue);
          }
          return textTheme.bodyMedium!.copyWith(color: AppColors.outline);
        },
      ),
    ),
  );

  /// Text Themes
  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
        color: AppColors.onBackground,
        fontSize: 57.0,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400),
    displaySmall: TextStyle(
        color: AppColors.onBackground,
        fontSize: 44.0,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(
        color: AppColors.onBackground,
        fontSize: 32.0,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400),
    headlineMedium: TextStyle(
        color: AppColors.onBackground,
        fontSize: 28.0,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400,
        height: 1.3),
    headlineSmall: TextStyle(
      color: AppColors.onBackground,
      fontSize: 24.0,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: AppColors.white,
      fontSize: 25.0,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
        color: AppColors.black,
        fontSize: 16.0,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
        height: 1.5),
    labelLarge: TextStyle(
        color: AppColors.onBackground,
        fontSize: 14.0,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
        height: 1.4),
    labelMedium: TextStyle(
      color: AppColors.black,
      fontSize: 12.0,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: AppColors.onBackground,
      fontSize: 11.0,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
        color: AppColors.onBackground,
        fontSize: 18.0,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400,
        height: 1.55),
    bodyMedium: TextStyle(
      color: AppColors.white,
      fontSize: 14.0,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
    bodySmall: TextStyle(
      color: AppColors.onBackground,
      fontSize: 12.0,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
  );
}
