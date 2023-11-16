import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/weekly_challeges/weekly_challenge.dart';
import 'package:gym_tec/pages/trainer/trainer_page/pin_input.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WeeklyRoutines extends StatefulWidget {
  const WeeklyRoutines({super.key});

  @override
  State<WeeklyRoutines> createState() => _WeeklyRoutinesState();
}

class _WeeklyRoutinesState extends State<WeeklyRoutines> {
  late WeeklyChallenge weeklyChallenge;
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;
  dynamic userId;
  int? validatingIndex;

  @override
  void initState(){
    final user = authService.currentUser;
    if (user == null) return;
    userId = user.uid;
    weeklyChallenge =  weeklyChallenge = WeeklyChallenge(
      date: Timestamp.now(),
      pin: "",
      exercises: [],
      successfulUsers: [],
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

  void _navigateToPinInput(int index) async {
    Navigator.pop(context);

    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pinInput(pin: weeklyChallenge.pin
          ),
        ));
    if (state == 'Reto validado exitosamente' && mounted){
      setState(() {
        validatingIndex = index;
        if (!weeklyChallenge.successfulUsers.contains(userId)) {
        weeklyChallenge.successfulUsers.add(userId);
      }
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state),
        duration: const Duration(seconds: 3),
      ),
    );
    
  }

  void _showBottomSheet(index){
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
                            child: Text(
                              '¿Qué hay que hacer?',
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
                        Text(
                          'Debe realizar ${weeklyChallenge.exercises[index].series} ${weeklyChallenge.exercises[index].series == 1 ? "serie" : "series"} de ${weeklyChallenge.exercises[index].repetitions} ${weeklyChallenge.exercises[index].repetitions == 1 ? "repetición" : "repeticiones"} de este ejercicio.\n\nAlgunos comentarios son: ${weeklyChallenge.exercises[index].comment.isNotEmpty ? weeklyChallenge.exercises[index].comment : "Ninguno"}',
                          style: const TextStyle(
                            fontWeight:
                              FontWeight.bold,
                              fontSize: 14,
                          ),
                        ),
                        const ContextSeparator(),
                        ActionBtn(title: "Marcar como completado", onPressed: () {
                          _navigateToPinInput(index);
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retos de la semana',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
        
      ),
    body: Skeletonizer(
      enabled: weeklyChallenge.exercises.isEmpty,
      child: Center(
      child:ContentPadding(
        child:Column(
          children: [
            Expanded(
              child: weeklyChallenge.exercises.isNotEmpty ?
              ListView.separated(
                itemCount: weeklyChallenge.exercises.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                const ContextSeparator(),
                itemBuilder: (context, index) {
                  bool isChallengeCompleted = validatingIndex == index && weeklyChallenge.successfulUsers.contains(userId);
                  // bool isChallengeCompleted = userId != null && weeklyChallenge.successfulUsers[index].contains(userId);
                  // String titleText = isChallengeCompleted
                  //   ? '${weeklyChallenge.exercises[index].name} ✓' // Agrega la marca de verificación si el reto está completado
                  //   : weeklyChallenge.exercises[index].name;
                  return CardBtn(
                    title: weeklyChallenge.exercises[index].name.toString(),
                    onPressed: isChallengeCompleted ? () {} : () => _showBottomSheet(index),
                    imgPath: isChallengeCompleted ? 'assets/images/check.png': null,
                    style:  isChallengeCompleted ? ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0A0A0A), // Fondo del botón con el código de color #282828
                      foregroundColor: Colors.white, // Color del texto blanco
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                      ),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 150), // Tamaño fijo del botón
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0), // Padding del botón
                    ): null,
                  );
                  },
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
                )
                
              ),
            ),
          ]
        )
      )
    )
  )
  );
  }
}
