import 'package:app_merchants_association/src/config/app_assets.dart';
import 'package:app_merchants_association/src/config/app_colors.dart';
import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/config/navigator_routes.dart';
import 'package:app_merchants_association/src/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _body(),
          ],
        ),
      )),
    );
  }

  /// Header de la pantalla de perfil
  /// Contiene el nombre del usuario, el icono para editar, la imagen de perfil y la categoría.
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
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5),
                  child: Text(
                    UserHelper.shop?.name! ?? "",
                    style: AppStyles.textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(color: AppColors.background),
                  child: Image.network(
                    "http://52.86.76.124:8000/shops/${UserHelper.shop?.id}/image/",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      UserHelper.shop?.sector! ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 11,
          right: 11,
          child: UserHelper.user!.shopOwner
              ? DropdownButton(
                  icon: Icon(
                    Icons.settings,
                    color: AppColors.white,
                  ),
                  underline: const SizedBox(),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                  },
                  items: [
                    DropdownMenuItem(
                      value: '',
                      child: InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, NavigatorRoutes.userManage),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_add_alt_sharp,
                                color: AppColors.black,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text("Usuarios",
                                  style: AppStyles.textTheme.labelLarge)
                            ],
                          )),
                    ),
                    DropdownMenuItem(
                      value: "",
                      child: InkWell(
                          onTap: () async {
                            await Navigator.pushNamed(
                                context, NavigatorRoutes.editShop);
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 30,
                                color: AppColors.black,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text("Editar tienda",
                                  style: AppStyles.textTheme.labelLarge)
                            ],
                          )),
                    ),
                    DropdownMenuItem(
                      value: '',
                      child: InkWell(
                          onTap: () async {
                            await UserHelper.deleteAllFromShared();
                            Navigator.pushReplacementNamed(
                                context, NavigatorRoutes.signIn);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 30,
                                color: AppColors.black,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text("Cerrar Sesion",
                                  style: AppStyles.textTheme.labelLarge)
                            ],
                          )),
                    ),
                  ],
                )
              : logOutIcon(false),
        ),
      ],
    );
  }

  Widget logOutIcon(bool blackButton) {
    return IconButton(
      onPressed: () async {
        await UserHelper.deleteAllFromShared();
        Navigator.pushReplacementNamed(context, NavigatorRoutes.signIn);
      },
      icon: Icon(
        Icons.logout,
        size: 30,
        color: blackButton ? AppColors.black : AppColors.white,
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: SingleChildScrollView(
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
            Text(
              // TODO Cambiar por la bio del usuario
              UserHelper.shop?.bio! ?? "",
              style: AppStyles.textTheme.labelMedium,
            ),
            const SizedBox(height: 50),
            Text(
              AppLocalizations.of(context)!.information,
              style: AppStyles.textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            _infoProfile(),
            const SizedBox(height: 50),
            Text(
              UserHelper.shop?.instagram != null ||
                      UserHelper.shop?.facebook != null
                  ? AppLocalizations.of(context)!.social_networks
                  : "",
              style: AppStyles.textTheme.titleMedium,
            ),
            _socialNetworks(),
          ],
        ),
      ),
    );
  }

  Widget _infoProfile() {
    return Column(
      children: [
        // First info row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: AppColors.primaryBlue,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.3),
                    child: Text(
                      UserHelper.shop?.schedule! ?? "",
                      style: AppStyles.textTheme.labelMedium?.copyWith(
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.wordpress,
                    color: AppColors.primaryBlue,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.3),
                        child: Text(
                          UserHelper.shop?.webpage != null
                              ? UserHelper.shop!.webpage!
                              : AppLocalizations.of(context)!.no_webpage,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textTheme.labelMedium?.copyWith(
                            fontSize: 10,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Second info row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primaryBlue,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  // TODO Cambiar por la dirección del usuario
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.3),
                    child: Text(
                      UserHelper.shop?.address! ?? "",
                      style: AppStyles.textTheme.labelMedium?.copyWith(
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    color: AppColors.primaryBlue,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.3),
                        child: Text(
                          UserHelper.shop?.phone! ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textTheme.labelMedium?.copyWith(
                            fontSize: 10,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Third info row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.mail_outline,
                    color: AppColors.primaryBlue,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  // TODO Cambiar por la dirección mail del usuario
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.3),
                    child: Text(
                      UserHelper.shop?.mail != null
                          ? UserHelper.shop!.mail!
                          : AppLocalizations.of(context)!.no_mail,
                      style: AppStyles.textTheme.labelMedium?.copyWith(
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialNetworks() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Row(
        children: [
          UserHelper.shop?.instagram != null
              ? InkWell(
                  onTap: () async {
                    try {
                      await launchUrl(Uri.parse(UserHelper.shop!.instagram!));
                    } catch (e) {
                      print('Error opening Instagram URL: $e');
                    }
                  },
                  child: Image.asset(
                    AppAssets.instagramLogo,
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          const SizedBox(width: 10),
          UserHelper.shop?.facebook != null
              ? InkWell(
                  onTap: () async {
                    try {
                      await launchUrl(Uri.parse(UserHelper.shop!.facebook!));
                    } catch (e) {
                      print('Error opening Instagram URL: $e');
                    }
                  },
                  child: Image.asset(
                    AppAssets.facebookLogo,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
