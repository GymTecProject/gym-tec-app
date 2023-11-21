import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/excercises/exercise.dart';
import 'package:gym_tec/models/routines/routine_exercise.dart';
import 'package:gym_tec/pages/user/routines/exercise_data.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class ManageExercisesPage extends StatefulWidget {

  const ManageExercisesPage({super.key});

  @override
  State<ManageExercisesPage> createState() => _ManageExercisesPage();
}

class _ManageExercisesPage extends State<ManageExercisesPage> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _modifyNameController = TextEditingController();
  final TextEditingController _modifyUrlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  int? _value;
  String actEntry = '';

  List<Exercise> _allExercises = [];
  List<Exercise> _foundExcercises = [];

  //RoutineExercise? _selectedExercise;
  Exercise? _selectedExercise;

  final List<String> items = [
    'Tren superior',
    'Tren inferior',
    'Funcional',
    'Cardio',
    'Core'
  ];

  String? selectedItem = 'Tren superior';

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
                  .contains(items[value].toLowerCase()) &&
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

  // fix name not changing in workout on save

  void _saveExercise(int index) {

    setState(() {
      
    });
  }

  void _createExercise() async {
    final Exercise exercise = Exercise(
      name: _nameController.text,
      category: selectedItem!,
      url: _urlController.text,
    );

    //function to create exercise

    _nameController.clear();
    _urlController.clear();
    setState(() {
      selectedItem = 'Tren superior';
    });

     Navigator.pop(context);
  }

  void showBottomSheetAddExercise() {
  String? localSelectedItem = selectedItem;

  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Agregar ejercicio',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const ContextSeparator(),
                      Flexible(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.info_outline),
                            labelText: 'Nombre del ejercicio',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const ItemSeparator(),
                     Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: localSelectedItem,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setModalState(() {
                                localSelectedItem = newValue;
                              });
                              setState(() {
                                selectedItem = newValue;
                              });
                            },
                            items: items.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      const ItemSeparator(),
                      Flexible(
                        child: TextFormField(
                          controller: _urlController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.link),
                            labelText: 'URL del video',

                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const ContextSeparator(),
                      ActionBtn(
                        title: "Guardar",
                        disabled: _nameController.text.isEmpty || _urlController.text.isEmpty,
                        onPressed: _createExercise,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
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
        actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle_outline_outlined),
              onPressed: () {
                showBottomSheetAddExercise();
              },
            ),
          ],
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
                ContentPadding(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < items.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ChoiceChip(
                                label: Text(items[i]),
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
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: _foundExcercises.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CardBtn(
                                title: _foundExcercises[index].name,
                                subtitle: _foundExcercises[index].category,
                                onPressed: () {
                                  setState(() {
                                    _modifyNameController.text = _foundExcercises[index].name;
                                    _modifyUrlController.text = _foundExcercises[index].url;
                                    selectedItem = _foundExcercises[index].category;
                                  });
                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context, StateSetter setModalState) {
                                          return Padding(
                                            padding: MediaQuery.of(context).viewInsets,
                                            child: SingleChildScrollView(
                                              child: Form(
                                                key: _formKey,
                                                child: Container(
                                                  padding: const EdgeInsets.all(24.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      const Text(
                                                        'Agregar ejercicio',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      const ContextSeparator(),
                                                      Flexible(
                                                        child: TextFormField(
                                                          controller: _modifyNameController,
                                                          decoration: const InputDecoration(
                                                            prefixIcon: Icon(Icons.info_outline),
                                                            labelText: 'Nombre del ejercicio',
                                                            border: OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                      const ItemSeparator(),
                                                    Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        child: DropdownButtonHideUnderline(
                                                          child: DropdownButton<String>(
                                                            isExpanded: true,
                                                            value: selectedItem,
                                                            icon: const Icon(Icons.arrow_drop_down),
                                                            iconSize: 24,
                                                            elevation: 16,
                                                            onChanged: (String? newValue) {
                                                              setModalState(() {
                                                                selectedItem = newValue;
                                                              });
                                                              setState(() {
                                                                selectedItem = newValue;
                                                              });
                                                            },
                                                            items: items.map<DropdownMenuItem<String>>(
                                                              (String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              },
                                                            ).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                      const ItemSeparator(),
                                                      Flexible(
                                                        child: TextFormField(
                                                          controller: _modifyUrlController,
                                                          decoration: const InputDecoration(
                                                            prefixIcon: Icon(Icons.link),
                                                            labelText: 'URL del video',
                                                            border: OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                      const ContextSeparator(),
                                                      ActionBtn(
                                                        title: "Guardar",
                                                        disabled: _nameController.text.isEmpty || _urlController.text.isEmpty,
                                                        onPressed: _createExercise,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ))),
              ],
            )));
  }
}
