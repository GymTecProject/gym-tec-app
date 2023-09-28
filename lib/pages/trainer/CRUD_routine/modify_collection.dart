import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/buttons/action_fab.dart';
import 'package:gym_tec/components/ui/buttons/expandable_fab.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/pages/Exercise/create_exercise.dart';

class ModifyCollectionPage extends StatefulWidget {
  final String buttonName;

  const ModifyCollectionPage({required this.buttonName, super.key});

  @override
  State<ModifyCollectionPage> createState() => _ModifyCollectionPageState();
}

class _ModifyCollectionPageState extends State<ModifyCollectionPage> {
  // Variables
  List<Widget> buttons = [];

  void addCollection() {
    setState(() {
      final buttonName = 'Ejercicio ${buttons.length + 1}';
      buttons.add(
        CardBtn(
          title: buttonName,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const CreateExercisePage(),
              ),
            );
          },
        ),
      );
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

  void _navigateToCreateExercise() async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateExercisePage(),
        ));
    if (!mounted) return;
    if (state == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rutina creada exitosamente /falta integrar/'),
          duration: Duration(seconds: 3),
        ),
      );
    }
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
