import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Onee chan'),
        ),
        body: Center(
          child: const Text('Onee chan'),
        ),
      ),
    );
  }
}
