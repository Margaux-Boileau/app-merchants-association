import 'package:app_merchants_association/src/config/app_assets.dart';
import 'package:app_merchants_association/src/config/app_colors.dart';
import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        ),
      ),
    );
  }

  /// Header de la pantalla de perfil
  /// Contiene el nombre del usuario, el icono para editar, la imagen de perfil y la categoría.
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      color: AppColors.primaryBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // TODO Quitar Strings Hardcodeados
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5),
                  child: Text(
                    "Cafè els amics",
                    style: AppStyles.textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
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
                // TODO Cambiar por la imagen del usuario
                'https://picsum.photos/200',
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
                  // TODO Cambiar por el nombre del usuario
                  'Cafeteria i granja',
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ],
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
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam eget nunc nec nunc tincidunt ultricies. Nullam eget nunc nec nunc tincidunt ultricies.",
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
              AppLocalizations.of(context)!.social_networks,
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
                  Text(
                    AppLocalizations.of(context)!.weekly_schedule,
                    style: AppStyles.textTheme.labelMedium?.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.wordpress,
                      color: AppColors.primaryBlue,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    // TODO Cambiar por la web del usuario
                    Flexible(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "www.caferestaurant.com",
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textTheme.labelMedium?.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                  Text(
                    "Carrer de Roses 58,\n08028 Barcelona",
                    style: AppStyles.textTheme.labelMedium?.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: AppColors.primaryBlue,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    // TODO Cambiar por la web del usuario
                    Flexible(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "www.caferestaurant.com",
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textTheme.labelMedium?.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                  // TODO Cambiar por la dirección del usuario
                  Text(
                    "mail@cafeteria.com",
                    style: AppStyles.textTheme.labelMedium?.copyWith(
                      fontSize: 10,
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
          InkWell(
            onTap: () {
              // TODO Abrir Instagram del usuario
            },
            child: Image.asset(
              AppAssets.instagramLogo,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              // TODO Abrir Facebook del usuario
            },
            child: Image.asset(
              AppAssets.facebookLogo,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              // TODO Abrir Linkedin del usuario
            },
            child: Image.asset(
              AppAssets.linkedinLogo,
              width: 41,
              height: 41,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
