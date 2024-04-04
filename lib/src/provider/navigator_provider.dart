import 'package:flutter/cupertino.dart';

enum BottomNavigationTabs {
  home,
  notices,
  notifications,
  profile,
}

class NavigationNotifier extends ChangeNotifier {
  BottomNavigationTabs _currentTab = BottomNavigationTabs.home;
  BottomNavigationTabs get currentTabIndex => _currentTab;
  int _currentIndex = 0;


  BottomNavigationTabs getCurrentTab () {
    return _currentTab;
  }

  void setCurrentTab(BottomNavigationTabs tab) {
    _currentTab = tab;
    _currentIndex = tab.index;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;


}

