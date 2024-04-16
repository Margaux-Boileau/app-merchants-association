import 'package:app_merchants_association/src/app.dart';
import 'package:app_merchants_association/src/helpers/user_helper.dart';
import 'package:app_merchants_association/src/provider/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(
    /// Providers
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationNotifier())],
      child: const AppComerciants()),
  );
}
