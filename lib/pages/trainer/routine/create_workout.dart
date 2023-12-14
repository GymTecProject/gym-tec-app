import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/buttons/action_fab.dart';
import 'package:gym_tec/components/ui/buttons/expandable_fab.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/models/routines/routine_exercise.dart';
import 'package:gym_tec/models/routines/routine_workout.dart';
import 'package:gym_tec/pages/trainer/routine/create_exercise.dart';

class CreateWorkout extends StatefulWidget {
  final String buttonName;
  final Map<int, String> weekDays;
  final Workout workout;
  final List<bool> collectionsCreated;
  final int collectionIndex;

  const CreateWorkout({
    super.key,
    required this.buttonName,
    required this.weekDays,
    required this.workout,
    required this.collectionsCreated,
    required this.collectionIndex,
  });

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  final ScrollController _scrollController = ScrollController();
  List<bool> exercisesCreated = [];

  @override
  void initState() {
    for (int i = 0; i < widget.workout.exercises.length; i++) {
      if (widget.workout.exercises[i].category == "") {
        exercisesCreated.add(false);
      }
      else{
        exercisesCreated.add(true);
      }
    }
    super.initState();
  }

  void setDays(int day) {
    setState(() {
      if (widget.workout.days.contains(day)) {
        widget.workout.days.remove(day);
        widget.weekDays[day] = "";
      } else {
        widget.workout.days.add(day);
        widget.weekDays[day] = widget.buttonName;
      }
    });
  }

  void addExercise() {
    setState(() {
      final RoutineExercise exercise = RoutineExercise(
        name: 'Ejercicio ${widget.workout.exercises.length + 1}',
        url: "",
        category: "",
        comment: "",
        series: 0,
        repetitions: 0,
      );
      widget.workout.exercises.add(exercise);
      exercisesCreated.add(false);
    });
  }

  void removeWorkout() {
    setState(() {
      if (widget.workout.exercises.isNotEmpty) {
        widget.workout.exercises.removeLast();
        exercisesCreated.removeLast();
      }
    });
  }

  void _updateCollectionsCreated() {

    bool isSelectedInWorkoutDays = widget.weekDays.entries.any(
    (e) => widget.workout.days.contains(e.key));

    
    widget.collectionsCreated[widget.collectionIndex] =
        widget.workout.exercises.isNotEmpty &&
            isSelectedInWorkoutDays &&
            exercisesCreated.every((element) => element == true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _updateCollectionsCreated();
        return true;
      },
      child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Modificar colección',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ContentPadding(
        child: Column(
          children: [
            Column(children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Días de la semana")),
              const ItemSeparator(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.weekDays.entries
                      .map((e) => InputChip(
                            label: Text(e.key.toString()),
                            showCheckmark: false,
                            isEnabled: !(widget.weekDays[e.key] !=
                                        widget.buttonName &&
                                    widget.weekDays[e.key] != ""),
                            selected: (widget.weekDays[e.key] ==
                                    widget.buttonName ||
                                widget.workout.days.contains(e.key)),
                            onPressed: () => setDays(e.key),
                          ))
                      .toList()),
            ]),
            const ContextSeparator(),
            Visibility(
                visible: widget.workout.exercises.isEmpty,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'No hay ejercicios creados, presiona ',
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
                itemCount: widget.workout.exercises.length + 1,
                itemBuilder: (context, index) {
                  if (index != widget.workout.exercises.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CardBtn(
                        title: widget.workout.exercises[index].name,
                        subtitle: "Series: ${widget.workout.exercises[index].series}\nRepeticiones: ${
                          widget.workout.exercises[index].repetitions}\nComentarios: ${
                            widget.workout.exercises[index].comment.isNotEmpty ? widget.workout.exercises[index].comment : "Ninguno"}",
                        onPressed: () async {
                          final exercise = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateExercisePage(
                                exercise: widget.workout.exercises[index],
                              ),
                            ),
                          );
                          if (exercise != null) {
                            setState(() {
                              widget.workout.exercises[index] = exercise;
                              exercisesCreated[index] = true;
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
        ActionFab(
          onPressed: removeWorkout,
          icon: const Icon(Icons.delete),
        ),
        ActionFab(
          onPressed: addExercise,
          icon: const Icon(Icons.add),
        )
      ]),
    ));
  }
}
