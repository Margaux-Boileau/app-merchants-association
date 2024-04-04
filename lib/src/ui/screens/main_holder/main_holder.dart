import 'package:app_merchants_association/src/config/app_colors.dart';
import 'package:app_merchants_association/src/ui/screens/main_holder/home.dart';
import 'package:app_merchants_association/src/ui/screens/main_holder/notices.dart';
import 'package:app_merchants_association/src/ui/screens/main_holder/notifications.dart';
import 'package:app_merchants_association/src/ui/screens/main_holder/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/navigator_provider.dart';

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
              Notices(),
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Foros',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.aspect_ratio),
                label: 'Noticias',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notificaciones',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        );
      },
    );
  }
}