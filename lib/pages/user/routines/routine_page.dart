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
import 'package:url_launcher/url_launcher.dart';
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
  List<Workout>? workout = [
    Workout(
      days: [1],
      exercises: [
        RoutineExercise(
            name: 'Cargando...',
            category: 'Cargando...',
            series: 0,
            repetitions: 0,
            weight: 0,
            url: "",
            comment: ""),
      ],
    ),
    Workout(
      days: [2],
      exercises: [
        RoutineExercise(
            name: 'Cargando...',
            category: 'Cargando...',
            series: 0,
            repetitions: 0,
            weight: 0,
            url: "",
            comment: ""),
      ],
    ),
    Workout(
      days: [3],
      exercises: [
        RoutineExercise(
            name: 'Cargando...',
            category: 'Cargando...',
            series: 0,
            repetitions: 0,
            weight: 0,
            url: "",
            comment: ""),
      ],
    ),
    Workout(
      days: [4],
      exercises: [
        RoutineExercise(
            name: 'Cargando...',
            category: 'Cargando...',
            series: 0,
            repetitions: 0,
            weight: 0,
            url: "",
            comment: ""),
      ],
    ),
    Workout(
      days: [5],
      exercises: [
        RoutineExercise(
            name: 'Cargando...',
            category: 'Cargando...',
            series: 0,
            repetitions: 0,
            weight: 0,
            url: "",
            comment: ""),
      ],
    ),
    Workout(
      days: [6],
      exercises: [
        RoutineExercise(
            name: 'Cargando...',
            category: 'Cargando...',
            series: 0,
            repetitions: 0,
            weight: 0,
            url: "",
            comment: ""),
      ],
    ),
    Workout(
      days: [7],
      exercises: [
        RoutineExercise(
            name: 'Cargando...',
            category: 'Cargando...',
            series: 0,
            repetitions: 0,
            weight: 0,
            url: "",
            comment: ""),
      ],
    ),
  ];

  void _fetchRoutineData() async {
    final user = authService.currentUser;

    if (user == null) return;
    final routineData = await dbService.getUserLastestRoutine(user.uid);
    if (routineData == null) {
      workout = null;
      routine = null;
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
    return categoies.keys
        .reduce((a, b) => categoies[a]! > categoies[b]! ? a : b);
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri(path: url))) {
      await launchUrl(Uri(path: url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openWhatsAppDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rutina Expirada'),
          content: const Text('Contactanos por Whatsapp para más información.'),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: const Text('Abrir Whatsapp'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  _launchURL('https://api.whatsapp.com/send?phone=50662735229');
                },
              ),
            ),
          ],
        );
      },
    );
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
    if (workout!.isNotEmpty) {
      setState(() {
        showSkeleton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Rutina',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      )),
      body: SingleChildScrollView(
        child: Skeletonizer(
          enabled: showSkeleton,
          child: routine != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: ContentPadding(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                routine == null
                                    ? Row(
                                        children: [
                                          Text(
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 26),
                                              'Fecha: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                            Text(
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 26),
                                                'Fecha: ${DateFormat('dd/MM/yyyy').format(routine!.date.toDate())}'),
                                            if (routine!.expirationDate
                                                .toDate()
                                                .isBefore(DateTime.now()))
                                              IconButton(
                                                onPressed: _openWhatsAppDialog,
                                                icon: const Icon(Icons
                                                    .warning_amber_rounded),
                                              ),
                                            IconButton(
                                                onPressed: _openHistroyDialog,
                                                icon: const Icon(
                                                    Icons.event_repeat)),
                                          ]),
                                const ContextSeparator(),
                                ListView.separated(
                                  itemCount: workout!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const ContextSeparator(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CardBtn(
                                      title:
                                          _getDaysTitle(workout![index].days),
                                      subtitle: _dayCategory(
                                          workout![index].exercises),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return RoutineDay(
                                                title: _getDaysTitle(
                                                    workout![index].days),
                                                exercises:
                                                    workout![index].exercises,
                                                workoutIndex: index,
                                                date: routine!.date,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No hay rutina asignada',
                       ),
                  ],
                )),
        ),
      ),
    );
  }
}
