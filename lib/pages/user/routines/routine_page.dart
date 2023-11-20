import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_tec/components/routines/routine_history.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/routines/routine_exercise.dart';
import 'package:gym_tec/models/routines/routine_workout.dart';
import 'package:gym_tec/pages/user/routines/routine_day.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../services/dependency_manager.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;
  bool showSkeleton = true;

  RoutineData? routine;
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
      routine = routineData;
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
        if (days.length > 1) {
          title = title.replaceRange(title.length - 2, null, ' y ');
        }
        title += days[i].toString();
      } else {
        title += '${days[i]}, ';
      }
    }
    return title;
  }

  String _dayCategory(List<RoutineExercise> day) {
    final Map<String, int> categoies = {};
    for (var data in day) { 
      if (categoies.containsKey(data.category)) {
        categoies[data.category] = categoies[data.category]! + 1;
      } else {
        categoies[data.category] = 1;
      }
    }
    return categoies.keys.reduce((a, b) => categoies[a]! > categoies[b]! ? a : b);
  }

  void _openHistroyDialog() async {
    final routineSelection = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return RoutineHistoryDialog(uid: authService.currentUser!.uid);
      },
    );
    if (routineSelection != null) {
      setState(() {
        routine = routineSelection;
        workout = routineSelection.workout;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRoutineData();
    Timer(const Duration(seconds: 5), () {
    // Comprueba si los datos se han cargado
    if (routine == null) {
      setState(() {
        showSkeleton = false; // Deja de mostrar el esqueleto después de 5 segundos
      });
    }
  });
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
                    routine != null
                        ? Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                        'Fecha: ${DateFormat('dd/MM/yyyy').format(routine!.date.toDate())}'),
                                    IconButton(
                                        onPressed: _openHistroyDialog,
                                        icon: const Icon(Icons.event_repeat)),
                                  ]),
                              const ContextSeparator(),
                              ListView.separated(
                                itemCount: workout.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const ContextSeparator(),
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return CardBtn(
                                    title: _getDaysTitle(workout[index].days),
                                    subtitle: _dayCategory(workout[index].exercises),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return RoutineDay(
                                              title: _getDaysTitle(
                                                  workout[index].days),
                                              exercises:
                                                  workout[index].exercises,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        : showSkeleton ? Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26),
                                      'Fecha: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
                                ]),
                            const ContextSeparator(),
                            Skeletonizer(
                              enabled: routine == null,
                              child: ListView.separated(
                                  itemCount: 4,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => CardBtn(
                                    title: 'No hay rutina asignada',
                                    onPressed: () => {},
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const ContextSeparator(),
                                ),
                            ),
                          ],
                        )
                      : const Text('No una hay rutina asignada'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // body: Skeletonizer(
      //   enabled: routine == null,
      //   child: SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         Center(
      //           child: ContentPadding(
      //             child: Column(
      //               children: [
      //                 Visibility(
      //                   visible: workout.isEmpty,
      //                   child: const Text('No una hay rutina asignada'),
      //                 ),
      //                 routine != null
      //                     ? Column(
      //                         children: [
      //                           Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Text(
      //                                     style: const TextStyle(
      //                                         fontWeight: FontWeight.bold,
      //                                         fontSize: 26),
      //                                     'Fecha: ${DateFormat('dd/MM/yyyy').format(routine!.date.toDate())}'),
      //                                 IconButton(
      //                                     onPressed: _openHistroyDialog,
      //                                     icon: const Icon(Icons.event_repeat)),
      //                               ]),
      //                           const ContextSeparator(),
      //                           ListView.separated(
      //                             itemCount: workout.length,
      //                             shrinkWrap: true,
      //                             physics: const NeverScrollableScrollPhysics(),
      //                             separatorBuilder: (context, index) =>
      //                                 const ContextSeparator(),
      //                             itemBuilder:
      //                                 (BuildContext context, int index) {
      //                               return CardBtn(
      //                                 title: _getDaysTitle(workout[index].days),
      //                                 subtitle: _dayCategory(workout[index].exercises),
      //                                 onPressed: () {
      //                                   Navigator.of(context).push(
      //                                     MaterialPageRoute(
      //                                       builder: (BuildContext context) {
      //                                         return RoutineDay(
      //                                           title: _getDaysTitle(
      //                                               workout[index].days),
      //                                           exercises:
      //                                               workout[index].exercises,
      //                                         );
      //                                       },
      //                                     ),
      //                                   );
      //                                 },
      //                               );
      //                             },
      //                           ),
      //                         ],
      //                       )
      //                     : ListView.separated(
      //                         itemCount: 7,
      //                         shrinkWrap: true,
      //                         itemBuilder: (context, index) => const Card(
      //                           child: Text('No hay rutina asignada'),
      //                         ),
      //                         separatorBuilder: (context, index) =>
      //                             const ContextSeparator(),
      //                       )
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
