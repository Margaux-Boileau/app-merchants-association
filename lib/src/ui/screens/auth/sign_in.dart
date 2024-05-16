import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/utils/dialog_manager.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/app_colors.dart';
import '../../../config/navigator_routes.dart';
import 'package:app_merchants_association/src/utils/helpers/user_helper.dart';
import '../../../utils/form_validation.dart';


class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  late DeviceInfoPlugin _deviceInfoPlugin;
  late Map<String, dynamic> _deviceData;

  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();

  var passwordController = TextEditingController();

  bool hintPassw = true;

  @override
  void initState() {
    _deviceInfoPlugin = DeviceInfoPlugin();
    super.initState();
  }

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
      bool? response = await ApiClient().signIn(usernameController.text, passwordController.text);

      if(response == true){
        String username = await UserHelper.getUsernameFromSharedPreferences();
        await UserHelper.getTokenFromSharedPreferences();
        Map<String, dynamic>? response = await ApiClient().getUsernameData(username);
        await UserHelper.setUser(response!);

        ///Enviar device token al back

        await _getDeviceInfo();
        FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
        _firebaseMessaging.getToken().then((token) async {

          _deviceData["fcm_token"] = token;

          await ApiClient().sendDeviceToken(_deviceData);
        });

        Navigator.pushReplacementNamed(context, NavigatorRoutes.mainHolder);
      }
      else{
        DialogManager().showSimpleDialog(
          context: context,
          title: AppLocalizations.of(context)!.atention,
          content: AppLocalizations.of(context)!.login_error,
        );
      }
    }
  }

  Future<void> _getDeviceInfo() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        setState(() {
          _deviceData = _readAndroidBuildData(androidInfo);
        });
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        setState(() {
          _deviceData = _readIosDeviceInfo(iosInfo);
        });
      }
    } catch (e) {
      setState(() {
        _deviceData = <String, dynamic>{'Error': 'Failed to get device info'};
      });
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'device_name': build.device,
      "device_id": build.id,
      "platform_type": "android",
      "fcm_token" : ""
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    // Implement parsing iOS device info here
    return <String, dynamic>{
      'device_name': data.model,
      "device_id": data.identifierForVendor,
      "platform_type": "IOS",
      "fcm_token" : ""
    };
  }



}