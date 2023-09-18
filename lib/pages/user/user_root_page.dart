import 'package:flutter/material.dart';
import 'package:gym_tec/components/navigation/nav_space.dart';
import 'package:gym_tec/components/navigation/nav_tab.dart';
import 'package:gym_tec/pages/user/home_page/home_page.dart';
import 'package:gym_tec/pages/settings_page.dart';
import 'package:gym_tec/pages/user/profile/profile.dart';

import 'package:gym_tec/pages/user/routines/routine_page.dart';

class UserRootPage extends StatelessWidget {
  const UserRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<NavTab> tabs = [
      NavTab(
        label: 'Inicio', 
        icon: Icon(Icons.home), 
        widget: HomePage()
        ),
      NavTab(
          label: 'Rutinas',
          icon: Icon(Icons.fitness_center),
          widget: RoutinePage()
        ),
      NavTab(
        label: 'Perfil',
        icon: Icon(Icons.person),
        widget: ProfilePage()
        ),
      NavTab(
          label: 'Ajustes', 
          icon: Icon(Icons.settings), 
          widget: SettingsPage()
        )
    ];

    return const NavSpace(tabs: tabs);
  }
}
