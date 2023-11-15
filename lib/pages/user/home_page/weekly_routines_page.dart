import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/weekly_challeges/weekly_challenge.dart';
import 'package:gym_tec/pages/trainer/trainer_page/pin_input.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class WeeklyRoutines extends StatefulWidget {
  const WeeklyRoutines({super.key});

  @override
  State<WeeklyRoutines> createState() => _WeeklyRoutinesState();
}

class _WeeklyRoutinesState extends State<WeeklyRoutines> {
  late final WeeklyChallenge weeklyChallenge;
  final DatabaseInterface dbService = DependencyManager.databaseService;

  @override
  void initState(){
    super.initState();
    _getWeeklyChallenge();
  }

  void _getWeeklyChallenge() async {
    WeeklyChallenge? lastWeeklyChallenge = await dbService.getLatestWeeklyChallenge();
    if (lastWeeklyChallenge != null) {
      setState(() {
        weeklyChallenge = lastWeeklyChallenge;
      });
    }
  }

  void _navigateToPinInput() async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pinInput(pin: weeklyChallenge.pin
          ),
        ));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state),
        duration: const Duration(seconds: 3),
      ),
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
    body: Center(
      child:ContentPadding(
        child:Column(
          children: [
            ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                const ContextSeparator(),
              itemBuilder: (context, index) => CardBtn(
                title: weeklyChallenge.exercises[index].name.toString(), 
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
                                        _navigateToPinInput();
                                      }),
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
          ]
        )
      )
    )
  );
  }
}
