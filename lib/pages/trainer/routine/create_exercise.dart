import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/excercises/exercise.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class CreateExercisePage extends StatefulWidget {
  const CreateExercisePage({super.key});

  @override
  State<CreateExercisePage> createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {
  final DatabaseInterface dbService = DependencyManager.databaseService;

  final List<String> _categories = [
    'Tren superior',
    'Tren inferior',
    'Funcional',
    'Cardio',
    'Core'
  ];
  int? _value;
  String actEntry = '';

  List<Exercise> _allExercises = [];
  List<Exercise> _foundExcercises = [];

  void _getAllExercises() async {
    try {
      var exercises = await dbService.getExercises();
      if (exercises.isNotEmpty) {
        setState(() {
          _allExercises = exercises;
          _foundExcercises = _allExercises;
        });
      }
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    _foundExcercises = _allExercises;
    super.initState();
    _getAllExercises();
  }

  void _runFilter(String entered) {
    List<Exercise> results = [];
    if (_value != null) {
      int value = _value!;
      results = _allExercises
          .where((item) =>
              item.category
                  .toLowerCase()
                  .contains(_categories[value].toLowerCase()) &&
              item.name.toLowerCase().contains(entered.toLowerCase()))
          .toList();
    } else {
      if (entered.isEmpty) {
        results = _allExercises;
      } else {
        results = _allExercises
            .where((item) =>
                item.name.toLowerCase().contains(entered.toLowerCase()))
            .toList();
      }
    }

    setState(() {
      _foundExcercises = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ejercicios',
            style: TextStyle(
              // color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          //backgroundColor:   Colors.transparent, // .of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SearchAnchor(
                  builder: (context, controller) => SearchBar(
                    hintText: 'Buscar Ejercicios',
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onChanged: (value) {
                      actEntry = value;
                      _runFilter(value);
                    },
                    trailing: const <Widget>[Icon(Icons.search)],
                  ),
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  },
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < _categories.length; i++)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ChoiceChip(
                              label: Text(_categories[i]),
                              selected: _value == i,
                              onSelected: (bool selected) {
                                setState(() {
                                  _value = selected ? i : null;
                                  _runFilter(actEntry);
                                });
                              },
                            ),
                          ),
                      ],
                    )),
                Expanded(
                    child: ListView.builder(
                        itemCount: _foundExcercises.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CardBtn(
                                title: _foundExcercises[index].name,
                                subtitle: _foundExcercises[index].category,
                                onPressed: () => showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text('Modal BottomSheet'),
                                            ElevatedButton(
                                              child: const Text(
                                                  'Close BottomSheet'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ))),
              ],
            )));
  }
}
