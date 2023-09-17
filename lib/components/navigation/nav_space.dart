import 'package:flutter/material.dart';
import 'package:gym_tec/components/navigation/nav_tab.dart';

class NavSpace extends StatefulWidget {
  const NavSpace({super.key, required this.tabs});

  final List<NavTab> tabs;

  @override
  State<NavSpace> createState() => _NavSpaceState();
}

class _NavSpaceState extends State<NavSpace> {
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return widget.tabs[_currentPage].widget;
              },
            ),
            bottomNavigationBar: NavigationBar(
              destinations: [
                  for (var tab in widget.tabs)
                  NavigationDestination(icon: tab.icon, label: tab.label),
              ],
              onDestinationSelected: (value) => setState(() {
                _currentPage = value;
              }),
              selectedIndex: _currentPage,

            )));
  }
}
