import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/config/navigator_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/navigator_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AppComerciants extends StatefulWidget {
  const AppComerciants({super.key});

  @override
  State<AppComerciants> createState() => _AppComerciantsState();
}

class _AppComerciantsState extends State<AppComerciants> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'App Comerciants',
      debugShowCheckedModeBanner: false,
      theme: AppStyles.mainTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Spanish
        // Locale('en'), // English
      ],
      locale: const Locale('es'),
      initialRoute: NavigatorRoutes.home,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
