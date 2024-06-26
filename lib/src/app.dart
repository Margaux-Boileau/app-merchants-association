import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/config/navigator_routes.dart';
import 'package:app_merchants_association/src/provider/push_notification_provider.dart';
import 'package:app_merchants_association/src/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/navigator_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppComerciants extends StatefulWidget {
  const AppComerciants({super.key});

  @override
  State<AppComerciants> createState() => _AppComerciantsState();
}

class _AppComerciantsState extends State<AppComerciants> {

  @override
  void initState() {
    super.initState();
    PushNotificationProvider().initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder<String>(
      future: setInitialRoute(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // Muestra un indicador de carga mientras se espera
        } else {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: 'App Comerciants',
              debugShowCheckedModeBanner: false,
              theme: AppStyles.mainTheme,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('es'), // Spanish
                Locale('ca'), // Catalan
                Locale('fr'), // Frances
                Locale('de'), // Aleman
                Locale('pt'), // Portuges
              ],
              initialRoute: snapshot.data, // Usa el valor de la función setInitialRoute()
              onGenerateRoute: AppRouter.generateRoute,
            ),
          );
        }
      },
    );
  }


  Future<String> setInitialRoute() async {
    await UserHelper.getTokenFromSharedPreferences();
    if(UserHelper.accessToken != null){

      String username = await UserHelper.getUsernameFromSharedPreferences();
      Map<String, dynamic>? response = await ApiClient().getUsernameData(username);

      if(response != null){
        print("RESPONSE DE USER -> $response");
        await UserHelper.setUser(response);
        return NavigatorRoutes.mainHolder;
      }
      else{
        await UserHelper.deleteAllFromShared();
        return NavigatorRoutes.signIn;
      }
    }
    else{
      return NavigatorRoutes.signIn;
    }
  }


}
