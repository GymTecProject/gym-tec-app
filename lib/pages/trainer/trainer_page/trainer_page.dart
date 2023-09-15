import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';

import 'package:gym_tec/pages/trainer/trainer_page/weekly_edit.dart';
import 'package:gym_tec/pages/trainer/trainer_page/search_user.dart';

class TrainerPage extends StatelessWidget {
  //Variables needed
  static const String date = 'MONDAY, SEPTEMBER 11';
  static const String firstName = 'Jack';
  static const String userType = "Trainer";

  static const double spaceBetweenButtons = 20.0;

  static const cardData = [
    {
      'title': 'Clients',
      'subtitle': 'Edit/Update Client\'s routines',
      'imgPath': 'assets/images/h-clients.png',
      'page': SearchUser(),
    },
    {
      'title': 'Set Weekly Challenges',
      'subtitle': 'Edit/Set Weekly Challenges',
      'imgPath': 'assets/images/h1-1.png',
      'page': EditChallenges(),
    },
  ];

  const TrainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '$userType\'s Tab',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: ContentPadding(
              child: Column(
                children: [
                  ListView.separated(
                    itemCount: cardData.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const ContextSeparator(),
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
