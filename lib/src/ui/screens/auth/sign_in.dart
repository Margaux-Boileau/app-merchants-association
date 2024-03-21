import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/app_colors.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/login_background.jpg",
              fit: BoxFit.cover,
            )
          ),
          loginCard(context)
        ],
      )
    );
  }

  Widget loginCard(BuildContext context){
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: AppColors.white
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "INICIAR SESIÓN",
                  style: AppStyles.textTheme.headlineLarge?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Divider(
                  color: AppColors.primaryBlue,
                  thickness: 4,
                ),
                TextFormField(

                  decoration: InputDecoration(
                    hintText: "Nombre de usuario...",

                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}