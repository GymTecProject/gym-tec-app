import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/buttons/action_fab.dart';
import 'package:gym_tec/components/ui/buttons/expandable_fab.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/routines/routine_exercise.dart';
import 'package:gym_tec/models/routines/routine_workout.dart';
import 'package:gym_tec/models/weekly_challeges/weekly_challenge.dart';
import 'package:gym_tec/pages/trainer/routine/create_exercise.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class AddWeeklyChallenges extends StatefulWidget {
  // final String buttonName;
  // final Map<int, String> weekDays;
  // final Workout workout;  
  final WeeklyChallenge weeklyChallenge;

  const AddWeeklyChallenges({
    super.key,
    required this.weeklyChallenge,
    });

  @override
  State<AddWeeklyChallenges> createState() => _AddWeeklyChallenges();
}

class _AddWeeklyChallenges extends State<AddWeeklyChallenges> {
  List<Widget> buttons = [];
  final ScrollController _scrollController = ScrollController();
  final DatabaseInterface dbService = DependencyManager.databaseService;

  void saveWeeklyChallenges() async {
    try{
      await dbService.createWeeklyChallenge(widget.weeklyChallenge.toJson());
      if (!mounted) return;
      Navigator.pop(context, 'Retos creados con éxito');
    } catch (e) {
      Navigator.pop(context, 'Error al crear los retos');
    }
  }

  void addExercise() {
    if (widget.weeklyChallenge.exercises.length < 3){
      setState(() {
      final RoutineExercise exercise = RoutineExercise(
        name: "",
        url: "",
        category: "",
        comment: "",
        series: 0,
        repetitions: 0,
      );
      widget.weeklyChallenge.exercises.add(exercise);
      });
    }
    else{
      showAddingChallengeError();
    }
    
  }

  void removeWorkout() {
    setState(() {
      if (widget.weeklyChallenge.exercises.isNotEmpty) {
        widget.weeklyChallenge.exercises.removeLast();
      }
    });
  }

  void showAddingChallengeError() {
    final challengeErrorSnackBar = SnackBar(
      content: Text(
        'No puedes agregar más de 3 retos por semana',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(challengeErrorSnackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Añadir retos de la semana',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ContentPadding(
        child: Column(
          children: [
            const ItemSeparator(),
            Visibility(
                visible: widget.weeklyChallenge.exercises.isEmpty,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'No hay retos creados, presiona ',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          )),
                      WidgetSpan(
                          child: Icon(Icons.edit,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary)),
                      TextSpan(
                          text: ' para crear uno nuevo',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ))
                    ]))),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: widget.weeklyChallenge.exercises.length + 1,
                itemBuilder: (context, index) {
                  if (index != widget.weeklyChallenge.exercises.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CardBtn(
                        title: "Reto ${index + 1}: ${widget.weeklyChallenge.exercises[index].name}",
                        onPressed: () async {
                          final exercise = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateExercisePage(
                                exercise: widget.weeklyChallenge.exercises[index],
                              ),
                            ),
                          );
                          if (exercise != null) {
                            setState(() {
                              widget.weeklyChallenge.exercises[index] = exercise;
                            });
                          }
                        },
                      ),
                    );
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ExpandableFab(distance: 100, children: [
        Visibility(
          visible: widget.weeklyChallenge.exercises.length == 3,
          child: ActionFab(
          onPressed: saveWeeklyChallenges,
          icon: const Icon(Icons.save),
          ),
        ),
        ActionFab(
          onPressed: removeWorkout,
          icon: const Icon(Icons.delete),
        ),
        ActionFab(
          onPressed: addExercise,
          icon: const Icon(Icons.add),
        )
      ]),
    );
  }
}
