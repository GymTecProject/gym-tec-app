import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';

import 'package:gym_tec/pages/trainer/trainer_page/weekly_edit.dart';
import 'package:gym_tec/pages/trainer/trainer_page/search_user.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class TrainerPage extends StatefulWidget {
  const TrainerPage({super.key});
  @override
  _TrainerPageState createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
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

  UserPrivateData? _userPrivateData;
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;
  static String userType = "Trainer";

  void _fetchUserPrivateData() async {
    final user = authService.currentUser;
    if (user == null) return;
    final userPrivateData = await dbService.getUserPrivateData(user.uid);
    if (userPrivateData == null) return;

    setState(() {
      _userPrivateData = userPrivateData;
      switch (_userPrivateData?.accountType) {
        case AccountType.administrator:
          userType = 'Admin';
        case AccountType.trainer:
          userType = 'Trainer';
        default:
          userType = '';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserPrivateData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '$userType\'s Tab',
              style: const TextStyle(
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
