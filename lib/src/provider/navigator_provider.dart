import 'package:flutter/material.dart';

enum BottomNavigationTabs {
  home,
  chat,
  profile
}

class NavigationNotifier extends ChangeNotifier {
  int _currentTab = 0;
  int get currentTabIndex => _currentTab;

  BottomNavigationTabs getCurrentTab () {
    switch(_currentTab) {
      case 0:
        return BottomNavigationTabs.home;
      case 1:
        return BottomNavigationTabs.chat;
      case 2:
        return BottomNavigationTabs.profile;
      default:
        return BottomNavigationTabs.home;
    }
  }

  void setCurrentTab(BottomNavigationTabs tab) {
    switch(tab) {
      case BottomNavigationTabs.home:
        _currentTab = 0;
        break;
      case BottomNavigationTabs.chat:
        _currentTab = 1;
        break;
      case BottomNavigationTabs.profile:
        _currentTab = 2;
        break;
    }
    notifyListeners();
  }
}
