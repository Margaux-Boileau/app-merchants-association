import 'package:flutter/material.dart';

class AppComerciants extends StatelessWidget {
  const AppComerciants({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Comerciants',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Onee chan'),
        ),
        body: Center(
          child: Container(
            child: const Text('Onee chan'),
          ),
        ),
      ),
    );
  }
}
