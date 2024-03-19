import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/config/navigator_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/navigator_router.dart';

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
      // localizationsDelegates: AL.localizationsDelegates,
      // supportedLocales: const [
      //   Locale('ca'),
      // ],
      initialRoute: NavigatorRoutes.signIn,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
