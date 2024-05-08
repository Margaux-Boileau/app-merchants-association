import 'package:app_merchants_association/src/config/app_colors.dart';
import 'package:app_merchants_association/src/ui/screens/main_holder/home.dart';
import 'package:app_merchants_association/src/ui/screens/main_holder/notices.dart';
import 'package:app_merchants_association/src/ui/screens/main_holder/notifications.dart';
import 'package:app_merchants_association/src/ui/screens/main_holder/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/navigator_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'audio_player.dart';

class MainHolder extends StatelessWidget {
  const MainHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationNotifier>(
      builder: (context, navigationNotifier, child) {
        return Scaffold(
          body: IndexedStack(
            index: navigationNotifier.currentIndex,
            children: const <Widget>[
              Home(),
              //Notices(),
              AudioPlayerScreen(),
              Notifications(),
              Profile(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationNotifier.currentIndex,
            onTap: (index) {
              navigationNotifier.setCurrentTab(BottomNavigationTabs.values[index]);
            },
            /// Estilo del bottom navigation
            backgroundColor: AppColors.primaryBlue,
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.white.withOpacity(0.5),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true, // Mostrar etiquetas solo para el ítem seleccionado
            showUnselectedLabels: false, // No mostrar etiquetas para ítems no seleccionados
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.message),
                label: AppLocalizations.of(context)!.forums,
              ),
              // BottomNavigationBarItem(
              //   icon: const Icon(Icons.library_books),
              //   label: AppLocalizations.of(context)!.news,
              // ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.radio),
                label: AppLocalizations.of(context)!.notifications,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.notifications),
                label: AppLocalizations.of(context)!.notifications
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.store),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
          ),
        );
      },
    );
  }
}