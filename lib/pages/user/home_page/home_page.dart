import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/pages/user/home_page/progress_page.dart';
import 'package:gym_tec/pages/user/routines/routine_page.dart';
import 'package:gym_tec/pages/user/home_page/weekly_routines_page.dart';
import 'package:gym_tec/services/dependency_manager.dart';

import 'package:intl/intl.dart';

import '../../../interfaces/auth_interface.dart';
import '../../../models/measures/measurements.dart';
import '../../trainer/trainer_page/view_measures_page.dart';

class HomePage extends StatefulWidget {
  //Variables needed
  static const String date = 'MONDAY, SEPTEMBER 11';
  static const String firstName = 'Jack';

  static const double spaceBetweenButtons = 20.0;

  static const cardData = [
    {
      'title': 'Rutina',
      'subtitle': 'Sigue tu rutina diaria',
      'imgPath': 'assets/images/h2-1.png',
      'page': RoutinePage(),
    },
    {
      'title': 'Reto semanal',
      'subtitle': 'Puedes completarlos todos?',
      'imgPath': 'assets/images/h1-1.png',
      'page': WeeklyRoutines(),
    },
    {
      'title': 'Progreso',
      'subtitle': 'Mira cuanto has avanzado!',
      'imgPath': 'assets/images/h3-1.png',
      'page': ProgressPage(),
    },
  ];

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;
  UserPublicData? _userPublicData;

  void _fetchUserPublicData() async {
    final user = authService.currentUser;
    if (user == null) return;
    final userPublicData = await dbService.getUserPublicData(user.uid);
    if (userPublicData == null) return;

    setState(() {
      _userPublicData = userPublicData;
    });
  }

  void _navigateToSeeMeasures(List<UserMeasurement>? m) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewMeasures(
            m: m,
          ),
        ));
  
  }

  @override
  void initState() {
    super.initState();
    _fetchUserPublicData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              DateFormat('EEEE, MMMM d').format(DateTime.now()).toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Hola, ${_userPublicData?.name.split(' ')[0]}!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ContextSeparator(),
          Center(
            child: ContentPadding(
              child: Column(
                children: [
                  ListView.separated(
                    itemCount: HomePage.cardData.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const ContextSeparator(),
                    itemBuilder: (context, index) => CardBtn(
                        title: HomePage.cardData[index]['title'] as String,
                        subtitle:
                            HomePage.cardData[index]['subtitle'] as String,
                        imgPath: HomePage.cardData[index]['imgPath'] as String,
                        onPressed: () async {
                          if (HomePage.cardData[index]['title'] == 'Progreso') {
                            // When "Progreso" is clicked, fetch user measurements and navigate
                            final userMeasurements =
                                await dbService.getUserMeasurements(
                                    authService.currentUser!.uid);
                            _navigateToSeeMeasures(userMeasurements);
                          } else {
                            // For other cards, navigate to the respective page
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return HomePage.cardData[index]['page']
                                      as Widget;
                                },
                              ),
                            );
                          }
                        }),
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
