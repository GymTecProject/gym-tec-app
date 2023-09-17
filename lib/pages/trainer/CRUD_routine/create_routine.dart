import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_fab.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/buttons/expandable_fab.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/pages/trainer/CRUD_routine/modify_collection.dart';

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({super.key});

  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  //Variables
  List<Widget> buttons = [];

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
                  builder: (context) =>
                      ModifyCollectionPage(buttonName: buttonName),
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
            Visibility(
                visible: buttons.isEmpty,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'No hay colecciones creadas, presiona ',
                      ),
                      WidgetSpan(
                          child: Icon(Icons.edit,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary)),
                      const TextSpan(text: ' para crear una nueva')
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
