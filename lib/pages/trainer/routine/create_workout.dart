import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/buttons/action_fab.dart';
import 'package:gym_tec/components/ui/buttons/expandable_fab.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/models/excercises/exercise.dart';
import 'package:gym_tec/models/routines/routine_workout.dart';
import 'package:gym_tec/pages/trainer/routine/create_exercise.dart';

class CreateWorkout extends StatefulWidget {
  final String buttonName;
  final Map<int, String> weekDays;
  final Workout workout;

  const CreateWorkout({
    super.key,
    required this.buttonName,
    required this.weekDays,
    required this.workout,
  });

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  List<Exercise> exercises = [];
  List<Widget> buttons = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
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
      final buttonName = 'Ejercicio ${buttons.length + 1}';
      buttons.add(
        CardBtn(
          title: buttonName,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateExercisePage(),
              ),
            );
          },
        ),
      );
    });
    _scrollToEnd();
  }

  void removeWorkout() {
    setState(() {
      if (buttons.isNotEmpty) {
        buttons.removeLast();
      }
    });
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const Text("Días"),
                  const ItemSeparator(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: widget.weekDays.entries
                          .map((e) => InputChip(
                                label: Text(e.key.toString()),
                                showCheckmark: false,
                                selected: (widget.weekDays[e.key] ==
                                        widget.buttonName ||
                                    widget.workout.days.contains(e.key)),
                                onPressed: (widget.weekDays[e.key] !=
                                            widget.buttonName &&
                                        widget.weekDays[e.key] != "")
                                    ? null
                                    : () => setDays(e.key),
                              ))
                          .toList()),
                ]),
              ),
            ),
            const ItemSeparator(),
            Visibility(
                visible: buttons.isEmpty,
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
                itemCount: buttons.length + 1,
                itemBuilder: (context, index) {
                  if (index != buttons.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: buttons[index],
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
    );
  }
}
