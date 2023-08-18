import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/home_button.dart';
import 'package:gym_tec/homePage/progress_page.dart';
import 'package:gym_tec/homePage/routine_page.dart';
import 'package:gym_tec/homePage/weekly_routines_page.dart';

class HomePage extends StatelessWidget {
  //Variables needed
  static const String date = 'MONDAY, SEPTEMBER 11';
  static const String firstName = 'Jack';

  static const double spaceBetweenButtons = 20.0;

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              date,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 50.0),
            child: Text(
              'Hi, $firstName!',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                HomeButton(
                  title: 'Weekly Challenges',
                  subtitle: 'Can you complete them all?',
                  imgPath: 'assets/images/h1-1.png',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const WeeklyRoutines();
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(
                    height:
                        spaceBetweenButtons), // Add spacing between the buttons

                HomeButton(
                  title: 'Routine',
                  subtitle: 'Follow your weekly routine',
                  imgPath: 'assets/images/h2-1.png',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const RoutinePage();
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(
                    height:
                        spaceBetweenButtons), // Add spacing between the buttons

                HomeButton(
                  title: 'Progress',
                  subtitle: 'See how far you\'ve gone',
                  imgPath: 'assets/images/h3-1.png',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const ProgressPage();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
