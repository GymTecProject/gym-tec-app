import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_fab.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/buttons/expandable_fab.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/routines/routine_workout.dart';
import 'package:gym_tec/pages/trainer/routine/create_workout.dart';

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({super.key});

  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  final Map<int, String> weekDays = {
    1: "",
    2: "",
    3: "",
    4: "",
    5: "",
    6: "",
    7: "",
  };
  late final RoutineData routine;
  List<Widget> buttons = [];
  int amountOfWeeks = 1;

  @override
  void initState() {
    super.initState();
    routine = RoutineData(
      date: Timestamp.now(),
      clientId: 'clientId',
      trainerId: 'trainerId',
      comments: [],
      workout: [],
      expirationDate: Timestamp.now(),
    );
  }

  void addWorkout(Workout workout, String buttonName) {
    setState(() {
      routine.workout.add(workout);
      for(int i in workout.days){
        weekDays[i] = buttonName;
      }
    });
  }

  void addCollection() {
    setState(() {
      if (buttons.length < 7) {
        final buttonName = 'Colección ${buttons.length + 1}';
        buttons.add(
          CardBtn(
            title: buttonName,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateWorkout(
                    buttonName: buttonName,
                    weekDays: weekDays,
                    callBack: addWorkout,
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }

  void removeCollection() {
    setState(() {
      if (buttons.isNotEmpty) {
        buttons.removeLast();
      }
    });
  }

  void saveRoutine() {
    bool saveState = true; // firestore service call
    Navigator.pop(context, saveState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear Rutina',
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
                  side:
                      BorderSide(color: Theme.of(context).colorScheme.outline),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const Text("Semanas de rutina"),
                  const ItemSeparator(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        5,
                        (index) => InputChip(
                              label: Text("${index + 2}"),
                              showCheckmark: false,
                              selected: amountOfWeeks == index + 2,
                              onPressed: () {
                                setState(() {
                                  amountOfWeeks = index + 2;
                                });
                              },
                            )).toList(),
                  ),
                ]),
              ),
            ),
            const ContextSeparator(),
            Visibility(
                visible: buttons.isEmpty,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'No hay colecciones creadas, presiona ',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          )),
                      WidgetSpan(
                          child: Icon(Icons.edit,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary)),
                      TextSpan(
                          text: ' para crear una nueva',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ))
                    ]))),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
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
          onPressed: saveRoutine,
          icon: const Icon(Icons.save),
        ),
        ActionFab(
          onPressed: removeCollection,
          icon: const Icon(Icons.delete),
        ),
        ActionFab(
          onPressed: addCollection,
          icon: const Icon(Icons.add),
        )
      ]),
    );
  }
}
