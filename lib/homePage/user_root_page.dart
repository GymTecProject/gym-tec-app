import 'package:flutter/material.dart';
import 'package:gym_tec/homePage/home_page.dart';
import 'package:gym_tec/homePage/settings_page.dart';
import 'package:gym_tec/profile/profile.dart';

class UserRootPage extends StatefulWidget {
  const UserRootPage({super.key});

  @override
  State<UserRootPage> createState() => _UserRootPageState();
}

class _UserRootPageState extends State<UserRootPage> {
  var _currentPage = 0;

  List<Widget> pages = const [
    HomePage(), // home
    HomePage(), // routines
    ProfilePage(), // profile
    SettingsPage() //settings
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final screenWidth = constraints.maxWidth;
                final screenHeight = constraints.maxHeight;
                debugPrint(
                    'Screen Width: $screenWidth, Screen Height: $screenHeight');

                return pages[_currentPage];
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              //backgroundColor: Color.fromARGB(255, 53, 45, 45),
              selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              unselectedItemColor: const Color.fromARGB(255, 155, 155, 155)
                  .withOpacity(0.5),
              currentIndex: _currentPage,
              onTap: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },

              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.fitness_center), label: 'Exercises'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings')
              ],
            )));
  }
}
