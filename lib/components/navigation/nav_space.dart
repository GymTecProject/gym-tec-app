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
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              unselectedItemColor: const Color.fromARGB(255, 155, 155, 155).withOpacity(0.5),
              currentIndex: _currentPage,
              onTap: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              items: [
                for (var tab in widget.tabs)
                  BottomNavigationBarItem(icon: tab.icon, label: tab.label),
              ],
            )));
  }
}
