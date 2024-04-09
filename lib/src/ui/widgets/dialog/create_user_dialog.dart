import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateUserDialog extends StatefulWidget {
  const CreateUserDialog({super.key});

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {

  var mailController = TextEditingController();

  var passwordController = TextEditingController();

  bool hintPassw = true;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      //backgroundColor: Color(0xffeceff8),
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        "Crear Usuario",
        style: AppStyles.textTheme.titleLarge,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: const EdgeInsets.symmetric(horizontal: 23),
      children: [
        dialogContent()
      ],
    );
  }

  // return Padding(
  // padding: const EdgeInsets.all(38),
  // child: Container(
  // color: AppColors.white,
  // child: dialogContent(),
  // ),
  // );

  Widget dialogContent(){
    return Column(
      children: [
        Divider(
          thickness: 3,
          color: AppColors.primaryBlue,
        ),
        const Icon(
          Icons.person,
          size: 120,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextFormField(
              controller: mailController,
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
          padding: const EdgeInsets.symmetric(vertical: 20),
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
        const SizedBox(height: 50,),
        ElevatedButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Crear Usuario",
            style: AppStyles.textTheme.titleSmall,
          ),
        ),
        SizedBox(height: 25,)
      ],
    );
  }
}
