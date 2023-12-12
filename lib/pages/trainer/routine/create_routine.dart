import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_fab.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/buttons/expandable_fab.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/routines/routine_workout.dart';
import 'package:gym_tec/pages/trainer/routine/create_workout.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class CreateRoutinePage extends StatefulWidget {
  final String clientId;

  const CreateRoutinePage({super.key, required this.clientId});

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
  List<bool> collectionsCreated = [];
  bool isChipSelected = false;
  int amountOfWeeks = 1;
  final ScrollController _scrollController = ScrollController();
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

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

  void addWorkout(String buttonName) {
    setState(() {});
  }

  void addCollection() {
    setState(() {
      if (routine.workout.length < 7) {
        final Workout newWorkout = Workout(
          exercises: [],
          days: [],
        );
        routine.workout.add(newWorkout);
        collectionsCreated.add(false);
      }
      _scrollToEnd();
    });
  }

  void removeCollection() {
    setState(() {
      if (routine.workout.isNotEmpty) {

        for(int day in routine.workout.last.days){
          weekDays[day] = "";
          }
        routine.workout.removeLast();
        
        collectionsCreated.removeLast();
      }
    });
  }

  void saveRoutine() async {
    final trainerId = authService.currentUser!.uid;
    final clientId = widget.clientId;
    final expirationDate =
        DateTime.now().add(Duration(days: (amountOfWeeks * 7)));

    final routineData = RoutineData(
      date: Timestamp.now(),
      clientId: clientId,
      trainerId: trainerId,
      comments: [],
      workout: routine.workout,
      expirationDate: Timestamp.fromDate(expirationDate),
    );
    try {
      await dbService.createRoutine(routineData.toJson());
      if (!mounted) return;
      Navigator.pop(context, 'Rutina creada con éxito');
    } catch (e) {
      Navigator.pop(context, 'Error al crear la rutina');
    }
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _navigateToCreateWorkout(String buttonName, int index){
    Navigator.push( context,
      MaterialPageRoute(
        builder: (context) => CreateWorkout(
            buttonName: buttonName,
            weekDays: weekDays,
            workout: routine.workout[index],
            collectionsCreated: collectionsCreated,
            collectionIndex: index,
        )
      ),
    ).then((result){
      setState(() {
        print(collectionsCreated.toString());
        print(weekDays.toString());
        if (result != null) {
          collectionsCreated[index] = true;
        }
      });
    });
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
            Column(children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Semanas de rutina")),
              const ItemSeparator(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    5,
                    (index) => InputChip(
                          label: Text("${index + 2}"),
                          showCheckmark: false,
                          selected: amountOfWeeks == index + 2,
                          onPressed: () {
                            setState(() {
                              amountOfWeeks = index + 2;
                              isChipSelected = true;
                            });
                          },
                        )).toList(),
              ),
            ]),
            const ContextSeparator(),
            Visibility(
                visible: routine.workout.isEmpty,
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
                controller: _scrollController,
                itemCount: routine.workout.length + 1,
                itemBuilder: (context, index) {
                  if (index != routine.workout.length) {
                    final buttonName = 'Colección ${index + 1}';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CardBtn(
                        title: buttonName,
                        onPressed: () => _navigateToCreateWorkout(buttonName, index)
                        ,
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
          onPressed: collectionsCreated.isNotEmpty && isChipSelected && collectionsCreated.every((item) => item)
            ? saveRoutine
            : null,
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
