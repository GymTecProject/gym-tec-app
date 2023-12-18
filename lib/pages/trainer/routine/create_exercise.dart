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
import 'package:gym_tec/services/dependency_manager.dart';

class CreateExercisePage extends StatefulWidget {
  final RoutineExercise exercise;

  const CreateExercisePage({super.key, required this.exercise});

  @override
  State<CreateExercisePage> createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  int? _value;
  String actEntry = '';

  List<Exercise> _allExercises = [];
  List<Exercise> _foundExcercises = [];

  RoutineExercise? _selectedExercise;

  bool _loadingData = true;

  final List<String> _categories = [
    'Tren superior',
    'Tren inferior',
    'Funcional',
    'Cardio',
    'Core'
  ];

  void _getAllExercises() async {
    try {
      var exercises = await dbService.getExercises();
      if (exercises.isNotEmpty) {
        setState(() {
          _allExercises = exercises;
          _foundExcercises = _allExercises;
          _loadingData = false;
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
    _setsController.text =
        widget.exercise.series != 0 ? widget.exercise.series.toString() : "";
    _repsController.text = widget.exercise.repetitions != 0
        ? widget.exercise.repetitions.toString()
        : "";
    _commentsController.text = widget.exercise.comment;

    _selectedExercise = RoutineExercise(
        name: "",
        url: "",
        category: "",
        comment: "",
        series: 0,
        repetitions: 0);

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

  // fix name not changing in workout on save

  void _saveExercise() {
    if (_formKey.currentState!.validate() && _selectedExercise != null) {
      _selectedExercise!.comment = _commentsController.text;
      _selectedExercise!.series = int.parse(_setsController.text);
      _selectedExercise!.repetitions = int.parse(_repsController.text);

      Navigator.pop(context);
      Navigator.pop(context, _selectedExercise);
    }
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
                ),
                Expanded(
                    child: _loadingData?
                    const Center(
                      child: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CircularProgressIndicator(),
                      ),
                    )
                    :ListView.builder(
                        itemCount: _foundExcercises.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CardBtn(
                                title: _foundExcercises[index].name,
                                subtitle: _foundExcercises[index].category,
                                onPressed: () {
                                  setState(() {
                                    _selectedExercise!.name =
                                        _foundExcercises[index].name;
                                    _selectedExercise!.url =
                                        _foundExcercises[index].url;
                                    _selectedExercise!.category =
                                        _foundExcercises[index].category;
                                  });
                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: SingleChildScrollView(
                                          child: Form(
                                            key: _formKey,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(24.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: TextFormField(
                                                          controller:
                                                              _setsController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: <TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          decoration:
                                                              const InputDecoration(
                                                            prefixIcon: Icon(
                                                                Icons
                                                                    .repeat_on),
                                                            labelText: 'Sets',
                                                            hintText: 'Ej: 3',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                      const ItemSeparator(),
                                                      Flexible(
                                                        child: TextFormField(
                                                          controller:
                                                              _repsController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: <TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          decoration:
                                                              const InputDecoration(
                                                            prefixIcon: Icon(Icons
                                                                .fitness_center),
                                                            labelText:
                                                                'Repeticiones',
                                                            hintText: 'Ej: 12',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const ContextSeparator(),
                                                  TextFormField(
                                                    controller:
                                                        _commentsController,
                                                    maxLines:
                                                        4, // Establece el número de líneas que desees
                                                    decoration:
                                                        const InputDecoration(
                                                      prefixIcon: Icon(
                                                          Icons.speaker_notes),
                                                      labelText: 'Comentarios',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  const ContextSeparator(),
                                                  ActionBtn(
                                                      title: "Guardar",
                                                      disabled: _setsController
                                                              .text.isEmpty ||
                                                          _repsController
                                                              .text.isEmpty,
                                                      onPressed: _saveExercise),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
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
