import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
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
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.all(24.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: TextFormField(
                                                    decoration: const InputDecoration(
                                                      prefixIcon: Icon(Icons.repeat_on),
                                                      labelText: 'Sets',
                                                      hintText: '4',
                                                      border: OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                ItemSeparator(),
                                                Flexible(
                                                  child: TextFormField(
                                                    decoration: const InputDecoration(
                                                      prefixIcon: Icon(Icons.fitness_center),
                                                      labelText: 'Repeticiones',
                                                      hintText: '10',
                                                      border: OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ItemSeparator(),
                                          TextField(
                                            maxLines: 4, // Establece el número de líneas que desees
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.speaker_notes),
                                              labelText: 'Comentarios',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          ContextSeparator(),
                                          ActionBtn(title: "Guardar", onPressed: () => Navigator.pop(context))
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

            /*
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  if (!_emailRegex.hasMatch(value)) {
                    return 'Por favor ingrese un correo electrónico válido';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Correo electrónico',
                    hintText: 'example@mail.com',
                    border: OutlineInputBorder()),
              ),
              const ItemSeparator(),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Contraseña',
                    hintText: 'Ingrese su contraseña',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: _hideText,
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off))),
                obscureText: _isObscure,
              ),
              const ContextSeparator(),
              ActionBtn(
                  title: 'Iniciar Sesión',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _userLoginFormData = UserLoginForm(
                          email: _emailController.text,
                          password: _passwordController.text);
                      submit(_userLoginFormData);
                    }
                  },
                  fontWeight: FontWeight.bold),
            ],
            
            */
  }
}
