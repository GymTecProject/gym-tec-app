import 'package:flutter/material.dart';
import 'package:gym_tec/components/navigation/nav_tab.dart';

class NavSpace extends StatefulWidget {
  const NavSpace({super.key, required this.tabs});

  final List<NavTab> tabs;

  @override
  State<NavSpace> createState() => _NavSpaceState();
}

class _NavSpaceState extends State<NavSpace> {
  int _currentPage = 0;

  void setTab(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: IndexedStack(
              index: _currentPage,
              children: [
                for (final tab in widget.tabs) tab.widget
              ]
            ),
            bottomNavigationBar: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              selectedIndex: _currentPage,
              onDestinationSelected: setTab,
              destinations: [
                for (final tab in widget.tabs)
                  NavigationDestination(
                    icon: tab.icon,
                    label: tab.label,
                  )
              ],
            )
              
            ));
  }
}
