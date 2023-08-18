import 'package:flutter/material.dart';
import 'package:gym_tec/homePage/home_page.dart';
import 'package:gym_tec/homePage/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Tec',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 96, 182, 39)),
        useMaterial3: true,
      ),
      home: const RootPage(title: 'Home Page'),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.title});

  final String title;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var _currentPage = 0;

  List<Widget> pages = const [
    HomePage(),
    HomePage(),
    HomePage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          selectedItemColor: const Color.fromARGB(255, 42, 42, 42),
          unselectedItemColor: const Color.fromARGB(255, 42, 42, 42)
              .withOpacity(0.5), // Unselected icon and text color
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
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ],
        ));
  }
}
