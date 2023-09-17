import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';

class ModifyCollectionPage extends StatefulWidget {
  final String buttonName;

  const ModifyCollectionPage({required this.buttonName, super.key});

  @override
  State<ModifyCollectionPage> createState() => _ModifyCollectionPageState();
}

class _ModifyCollectionPageState extends State<ModifyCollectionPage> {
  // Variables
  List<Widget> buttons = [];
  List<int> selectedButtonIndexes = [];
  int exerciseCount = 0; // Track the number of added exercises

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar ${widget.buttonName}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // day buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                return Expanded( 
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedButtonIndexes.contains(index)) {
                            selectedButtonIndexes.remove(index);
                          } else {
                            selectedButtonIndexes.add(index);
                          }
                        });
                      },
                      child: Container(
                        height: 50, // buttons height
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedButtonIndexes.contains(index)
                              ? const Color(0xFFA7F502) // while selected
                              : const Color(0xFFC0C0C0), // default
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            // Add exercise buttons
            Expanded(
              child: ListView.builder(
                itemCount: buttons.length + 1,
                itemBuilder: (context, index) {
                  if (index == buttons.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ActionBtn(
                        title: '+',
                        onPressed: () {
                          final exerciseName = 'Ejercicio ${exerciseCount + 1}';
                          buttons.add(
                            CardBtn(
                              title: exerciseName,
                              onPressed: () {
                                
                              },
                              
                              /*
                              onPressed: () {

                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  exerciseName,
                                  style: const TextStyle(fontSize: 24.0),
                                ),
                              ),*/
                            ),
                          );
                          setState(() {
                            exerciseCount++; // Increment the exercise count
                          });
                        },
                        fontSize: 24,
                        /*child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Icon(Icons.add),
                        ),*/
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: buttons[index],
                  );
                },
              ),
            ),
            // Save button
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
