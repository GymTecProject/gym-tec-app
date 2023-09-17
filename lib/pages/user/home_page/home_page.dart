import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/pages/user/home_page/progress_page.dart';
import 'package:gym_tec/pages/user/routines/routine_page.dart';
import 'package:gym_tec/pages/user/home_page/weekly_routines_page.dart';

class HomePage extends StatelessWidget {
  //Variables needed
  static const String date = 'MONDAY, SEPTEMBER 11';
  static const String firstName = 'Jack';

  static const double spaceBetweenButtons = 20.0;

  static const cardData = [
    {
      'title': 'Weekly Challenges',
      'subtitle': 'Can you complete them all?',
      'imgPath': 'assets/images/h1-1.png',
      'page': WeeklyRoutines(),
    },
    {
      'title': 'Routine',
      'subtitle': 'Follow your weekly routine',
      'imgPath': 'assets/images/h2-1.png',
      'page': RoutinePage(),
    },
    {
      'title': 'Progress',
      'subtitle': 'See how far you\'ve gone',
      'imgPath': 'assets/images/h3-1.png',
      'page': ProgressPage(),
    },
  ];

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              date,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 16,
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Hi, $firstName!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: ContentPadding(
              child: Column(
                children: [
                  ListView.separated(
                    itemCount: cardData.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const ContextSeparator(),
                    itemBuilder: (context, index) => CardBtn(
                      title: cardData[index]['title'] as String,
                      subtitle: cardData[index]['subtitle'] as String,
                      imgPath: cardData[index]['imgPath'] as String,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return cardData[index]['page'] as Widget;
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
