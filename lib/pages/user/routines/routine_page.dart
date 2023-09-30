import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/pages/user/routines/routine_data.dart';
import 'package:gym_tec/pages/user/routines/routine_day.dart';

import '../../../services/dependency_manager.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {

  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  late var _routineData;

  void _fetchRoutineData() async {
    final user = authService.currentUser;
    if (user == null) return;
    _routineData = await dbService.getUserRoutine(user.uid);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchRoutineData();
  }
  
  final List<RoutineData> routines = [
    RoutineData(
      title: 'Rutina 1',
      subtitle: 'Rutina de principiante',
      imgPath: 'assets/images/h2-1.png',
    ),
    RoutineData(
      title: 'Rutina 2',
      subtitle: 'Rutina de intermedio',
      imgPath: 'assets/images/h2-1.png',
    ),
    RoutineData(
      title: 'Rutina 3',
      subtitle: 'Rutina de avanzado',
      imgPath: 'assets/images/h2-1.png',
    ),
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutina'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ContentPadding(
                child: Column(
                  children: [
                    ListView.separated(
                      itemCount: routines.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const ContextSeparator(),
                      itemBuilder: (BuildContext context, int index) {
                        return CardBtn(
                          title: routines[index].title,
                          subtitle: routines[index].subtitle,
                          imgPath: routines[index].imgPath,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RoutineDay();
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
