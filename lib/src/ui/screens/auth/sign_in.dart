import 'dart:math';

import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/app_colors.dart';
import '../../../config/navigator_routes.dart';
import '../../../helpers/user_helper.dart';
import '../../../utils/form_validation.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();

  var passwordController = TextEditingController();

  bool hintPassw = true;

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
        height: MediaQuery.of(context).size.height * 0.65,
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
                  AppLocalizations.of(context)!.login,
                  style: AppStyles.textTheme.headlineLarge?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Divider(
                  color: AppColors.primaryBlue,
                  thickness: 4,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.username_separated,
                      fillColor: Colors.white,
                      hintText: AppLocalizations.of(context)!.username_separated,
                      hintStyle: const TextStyle(
                        fontSize: 15
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                    ),
                    validator: (value) => FormValidation.validateUsername(value!, context)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: hintPassw,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.password,
                      fillColor: Colors.white,
                      hintText: AppLocalizations.of(context)!.password,
                      hintStyle: const TextStyle(
                          fontSize: 15
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            hintPassw = !hintPassw;
                          });
                        },
                        icon: Icon(
                          hintPassw ? Icons.visibility : Icons.visibility_off_rounded,
                          color: AppColors.outline,
                        ),
                      ),
                    ),
                    validator: (value) => FormValidation.validatePassword(value!, context)
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: AppStyles.textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  login() async {
    if(_formKey.currentState!.validate()){
      bool response = await ApiClient().signIn(usernameController.text, passwordController.text);

      if(response){
        Navigator.pushReplacementNamed(context, NavigatorRoutes.mainHolder);
      }
      else{
        print("error");
      }
    }
  }

}