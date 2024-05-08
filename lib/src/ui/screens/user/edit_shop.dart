import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../api/api_client.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_styles.dart';
import '../../../config/navigator_routes.dart';
import '../../../model/shop.dart';
import '../../../utils/form_validation.dart';
import '../../../utils/helpers/user_helper.dart';

class EditShop extends StatefulWidget {
  const EditShop({super.key});

  @override
  State<EditShop> createState() => _EditShopState();
}

class _EditShopState extends State<EditShop> {
  final _formKey = GlobalKey<FormState>();

  ///CONTOLLERS
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopBioController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController facebookController = TextEditingController();

  @override
  void initState() {
    Shop shop = UserHelper.shop!;
    super.initState();

    shopNameController.text = shop.name ?? "";
    shopBioController.text = shop.bio ?? "";
    scheduleController.text = shop.schedule ?? "";
    locationController.text = shop.address ?? "";
    webController.text = shop.webpage ?? "";
    phoneController.text = shop.phone ?? "";
    mailController.text = shop.mail ?? "";
    instagramController.text = shop.instagram ?? "";
    facebookController.text = shop.facebook ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _header(),
              _body(),
              _editButton()
            ],
          ),
        ),
      ),
    ));
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              AppLocalizations.of(context)!.bio,
              style: AppStyles.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: shopBioController,
                maxLines: 8,
                minLines: 1,
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Biografia...",
                  hintStyle: const TextStyle(fontSize: 15),
                ),
                validator: (value) =>
                    FormValidation.validateEmpty(value!, context)),
          ),
          const SizedBox(height: 50),
          Text(
            AppLocalizations.of(context)!.information,
            style: AppStyles.textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: scheduleController,
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Horario...",
                  hintStyle: const TextStyle(fontSize: 15),
                  prefixIcon: const Icon(
                    Icons.schedule_outlined,
                  ),
                ),
                validator: (value) =>
                    FormValidation.validateEmpty(value!, context)),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: locationController,
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Direccion...",
                  hintStyle: const TextStyle(fontSize: 15),
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                  ),
                ),
                validator: (value) =>
                    FormValidation.validateEmpty(value!, context)),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: webController,
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Web URL...",
                  hintStyle: const TextStyle(fontSize: 15),
                  prefixIcon: const Icon(
                    Icons.wordpress,
                  ),
                )),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: phoneController,
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Telefono...",
                  hintStyle: const TextStyle(fontSize: 15),
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                  ),
                ),
                validator: (value) =>
                    FormValidation.validateEmpty(value!, context)),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: mailController,
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Correo electronico...",
                  hintStyle: const TextStyle(fontSize: 15),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                )),
          ),
          const SizedBox(height: 50),
          Text(
            AppLocalizations.of(context)!.social_networks,
            style: AppStyles.textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: instagramController,
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Instagram...",
                  hintStyle: const TextStyle(fontSize: 15),
                  prefixIcon: const Icon(
                    FontAwesomeIcons.instagram,
                  ),
                )),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: facebookController,
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Facebook...",
                  hintStyle: const TextStyle(fontSize: 15),
                  prefixIcon: const Icon(
                    FontAwesomeIcons.facebook,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          width: double.infinity,
          color: AppColors.primaryBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(color: AppColors.background),
                  child: Image.network(
                    "http://172.23.6.211:8000/shops/${UserHelper.shop?.id}/image/",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 8, 50, 12),
                child: TextFormField(
                    controller: shopNameController,
                    style: TextStyle(color: AppColors.black),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Nombre de la tienda...",
                      hintStyle: const TextStyle(fontSize: 15),
                      prefixIcon: const Icon(
                        Icons.store,
                      ),
                    ),
                    validator: (value) =>
                        FormValidation.validateEmpty(value!, context)),
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: AppColors.white,
              )),
        ),
      ],
    );
  }

  Widget _editButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () async {

          if(_formKey.currentState!.validate()){
            var response = await ApiClient().editShop(
                name: shopNameController.text,
                address: locationController.text,
                bio: shopBioController.text,
                schedule: scheduleController.text,
                phone: phoneController.text,
                instagram: instagramController.text,
                facebook: facebookController.text,
                webpage: webController.text,
                mail: mailController.text,
                shopId: UserHelper.shop!.id!);

            if(response != null){
              await UserHelper.setShop(response);
            }
            Navigator.pop(context);
          }

        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          "GUARDAR",
          style: AppStyles.textTheme.titleSmall,
        ),
      ),
    );
  }

}
