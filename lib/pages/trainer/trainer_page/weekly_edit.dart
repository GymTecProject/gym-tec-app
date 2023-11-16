import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/weekly_challeges/weekly_challenge.dart';
import 'package:gym_tec/pages/trainer/trainer_page/add_weekly_challenges.dart';
import 'dart:math';

import 'package:gym_tec/services/dependency_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';


class EditChallenges extends StatefulWidget {
  const EditChallenges({super.key});

  @override
  State<EditChallenges> createState() => _EditChallengesState();
}

class _EditChallengesState extends State<EditChallenges> {
  
  late WeeklyChallenge weeklyChallenge;
  final DatabaseInterface dbService = DependencyManager.databaseService;

  @override
  void initState(){
    weeklyChallenge =  weeklyChallenge = WeeklyChallenge(
      date: Timestamp.now(),
      pin: generatePIN(),
      exercises: [],
    );
    _getWeeklyChallenge();
    super.initState();
  }

  void _getWeeklyChallenge() async {
    WeeklyChallenge? lastWeeklyChallenge = await dbService.getLatestWeeklyChallenge();
    if (lastWeeklyChallenge != null) {
      setState(() {
        weeklyChallenge = lastWeeklyChallenge;
      });
    }
  }

  void _navigateToAddWeeklyChallenge() async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddWeeklyChallenges(
            weeklyChallenge: weeklyChallenge,
          ),
        ));

    setState(() {
      _getWeeklyChallenge();
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String generatePIN() {
    var random = Random();
    int number = random.nextInt(9000) + 1000;
    return number.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Retos de la semana',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
        
      ),
    body: Center(
      child: ContentPadding(
        child: Column(
          children: [
            Expanded(
              child: Skeletonizer(
                enabled: weeklyChallenge.exercises.isEmpty,
                child: weeklyChallenge.exercises.isNotEmpty
                    ? ListView.separated(
                        itemCount: weeklyChallenge.exercises.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const ContextSeparator(),
                        itemBuilder: (context, index) => CardBtn(
                          title: "Reto ${index + 1}: ${weeklyChallenge.exercises[index].name}",
                    onPressed: ()=>{
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding:
                                MediaQuery.of(context).viewInsets,
                            child: SingleChildScrollView(
                              child: Form(
                                child: Container(
                                  padding:
                                      const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Row(
                                        children: [
                                          Flexible(
                                            child: Card(
                                              elevation: 0, // Esto elimina la sombra
                                              color: Colors.transparent, // Esto hace que el fondo sea transparenteto asegura que no haya un borde visible
                                              child: Text(
                                                'El PIN del reto es:',
                                              style: TextStyle(
                                                fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 20,
                                              ),
                                            )),
                                          ),
                                        ],
                                    ),
                                    const ContextSeparator(),
                                    Text(weeklyChallenge.pin, style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )),
                                    const ContextSeparator(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    }
                  ),
                )
                : ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Column(
                  children: [
                    CardBtn(
                      title: "Nombre de ejemplo",
                      onPressed: () => {},
                    ),
                    const ContextSeparator(),
                  ],
                ),
              ),
              )),
                ActionBtn(title: "Actualizar", fontWeight:FontWeight.bold, onPressed: () {
                  try {
                    // Actualiza el reto semanal.
                    setState(() {
                      weeklyChallenge = WeeklyChallenge(
                        date: Timestamp.now(),
                        pin: generatePIN(),
                        exercises: [],
                      );
                    });

                    // Navega a la siguiente página.
                    _navigateToAddWeeklyChallenge();
                  } catch (e) {
                    // Si ocurre una excepción, imprímela en la consola.
                    print('Ocurrió un error: $e');
                  }
                }),
            ]
          )
        )
      )
    );
  }         
}