import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/pages/trainer/CRUD_routine/modify_collection.dart';

import '../../../components/ui/buttons/action_btn.dart';

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({super.key});

  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  //Variables
  List<Widget> buttons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear Rutina',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [    
            Expanded(
              child: ListView.builder(
                itemCount: buttons.length + 1,
                itemBuilder: (context, index) {
                  if (index == buttons.length) {
                    return Visibility(
                      visible: buttons.length < 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ActionBtn(
                          title: '+',
                          onPressed: () {
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
                                          builder: (context) => ModifyCollectionPage(buttonName: buttonName),
                                        ),
                                      );
                                    },
                                    //child: Padding(
                                    //  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    //  child: Text(
                                    //    'Colección ${buttons.length + 1}',
                                    //    style: const TextStyle(fontSize: 24.0),
                                    //  ),
                                    //),
                                  ),
                                );
                              }
                            });
                          },
                          //child: const Padding(
                          //  padding: EdgeInsets.symmetric(vertical: 12.0),
                          //  child: Icon(Icons.add),
                          //),
                        fontSize: 24,),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: buttons[index],
                  );
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              /*child: ElevatedButton(
                onPressed: () {
                  // save logic
                },
                child: const Text(
                  'Guardar',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),*/
              child: ActionBtn(title: 'Guardar', onPressed: () {
                  // save logic
              }, fontSize: 24, )
            ),
          ],
      ),
    ),
    );
  }
}
