import 'package:flutter/material.dart';
import 'package:gym_tec/components/navigation/nav_space.dart';
import 'package:gym_tec/components/navigation/nav_tab.dart';

import 'package:gym_tec/pages/user/home_page/home_page.dart';
import 'package:gym_tec/pages/settings_page.dart';
import 'package:gym_tec/pages/user/profile/profile.dart';

import 'package:gym_tec/pages/trainer/trainer_page/trainer_page.dart';

class AdminRootPage extends StatelessWidget {
  const AdminRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<NavTab> tabs = [
      NavTab(label: 'Home', icon: Icon(Icons.home), widget: HomePage()),
      NavTab(
          label: 'Admin',
          icon: Icon(Icons.accessibility_new),
          widget: TrainerPage()),
      NavTab(label: 'Profile', icon: Icon(Icons.person), widget: ProfilePage()),
      NavTab(
          label: 'Settings',
          icon: Icon(Icons.settings),
          widget: SettingsPage()),
    ];

    return const NavSpace(tabs: tabs);
  }
}
