import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/routines/routine_workout.dart';
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

  List<Workout> workout = [];

  void _fetchRoutineData() async {
    final user = authService.currentUser;

    if (user == null) return;
    final routineData = await dbService.getUserLastestRoutine(user.uid);
    if (routineData == null) {
      workout = [];
      return;
    }
    setState(() {
      workout = routineData.workout;
    });
  }

  String _getDaysTitle(List<int> days) {
    String title = '';
    if (days.length > 1) {
      title = 'Días: ';
    } else {
      title = 'Día: ';
    }
    for (int i = 0; i < days.length; i++) {
      if (i == days.length - 1) {
        if(days.length > 1) title = title.replaceRange(title.length - 2, null, ' y ');
        title += days[i].toString();
      } else {
        title += '${days[i]}, ';
      }
    }
    return title;
  }

  @override
  void initState() {
    super.initState();
    _fetchRoutineData();
  }

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
                      itemCount: workout.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const ContextSeparator(),
                      itemBuilder: (BuildContext context, int index) {
                        return CardBtn(
                          title: _getDaysTitle(workout[index].days),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RoutineDay(
                                    title: _getDaysTitle(workout[index].days),
                                    exercises: workout[index].exercises,
                                  );
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
