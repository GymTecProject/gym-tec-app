import 'package:flutter/material.dart';
import 'package:gym_tec/components/navigation/nav_space.dart';
import 'package:gym_tec/components/navigation/nav_tab.dart';

import 'package:gym_tec/pages/user/home_page/home_page.dart';
import 'package:gym_tec/pages/settings_page.dart';
import 'package:gym_tec/pages/user/profile/profile.dart';

import 'package:gym_tec/pages/admin/admin_page/admin_page.dart';

class AdminRootPage extends StatelessWidget {
  const AdminRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<NavTab> tabs = [
      NavTab(label: 'Inicio', icon: Icon(Icons.home), widget: HomePage()),
      NavTab(
          label: 'Administrar',
          icon: Icon(Icons.admin_panel_settings),
          widget: AdminPage()),
      NavTab(label: 'Perfil', icon: Icon(Icons.person), widget: ProfilePage()),
      NavTab(
          label: 'Ajustes',
          icon: Icon(Icons.settings),
          widget: SettingsPage()),
    ];

    return const NavSpace(tabs: tabs);
  }
}
