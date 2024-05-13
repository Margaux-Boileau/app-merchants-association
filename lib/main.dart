import 'package:app_merchants_association/src/app.dart';
import 'package:app_merchants_association/src/provider/audio_provider.dart';
import 'package:app_merchants_association/src/provider/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(
    /// Providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationNotifier()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: const AppComerciants()),
  );
}
