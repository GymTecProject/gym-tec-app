import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';

class CreateExercisePage extends StatefulWidget {
  const CreateExercisePage({super.key});

  @override
  State<CreateExercisePage> createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {

  final List<String> _categories = ['Pecho', 'Espalda', 'Hombro', 'Biceps', 'Triceps', 'Pierna'];
  int? _value;
  String actEntry = '';

  final List<Map<String, dynamic>> _allUsers = [
    // UserPublicData
    {
      "name": "Press de Pecho",
      "category": "Pecho",
    },
    {
      "name": "Press de Pecho con barra",
      "category": "Pecho",
    },
    {
      "name": "Press Militar",
      "category": "Hombro",
    },
    {
      "name": "Extensión de Pierna",
      "category": "Pierna",
    },
    {
      "name": "Sentadilla Sumo Smith",
      "category": "Pierna",
    },
    {
      "name": "Press Barra Romana",
      "category": "Triceps",
    },
    {
      "name": "Flexión de Codo Mancuerna",
      "category": "Biceps",
    },
    {
      "name": "Crossover Polea",
      "category": "Pecho",
    },
    {
      "name": "Jalón Polea Abierto",
      "category": "Espalda",
    },
    {
      "name": "Remo Barra T Libre",
      "category": "Espalda",
    },
    {
      "name": "Patada de Mula Polea",
      "category": "Triceps",
    },
    
  ];

  //age, gender, role, medical conditions, objective, expiration date
  //Dialog -> height, water, protein, minerals, fat, weight, skeletalMuscleMass, imc, fatPercentage

  List<Map<String, dynamic>> _foundUsers = [];
  @override
  void initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String entered) {
    List<Map<String, dynamic>> results = [];
    if (_value != null) {
        int value = _value!;
        results = _allUsers
          .where((user) =>
              user["category"].toLowerCase().contains(_categories[value].toLowerCase() ) && user["name"].toLowerCase().contains(entered.toLowerCase()))
          .toList();
      }
    else {
     if (entered.isEmpty) {
      results = _allUsers;
    } 
      else{
        results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(entered.toLowerCase()))
          .toList();
      }
    }

    setState(() {
      _foundUsers = results;
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
        children:[
          const SizedBox(
            height: 10,
          ),
          Padding(padding: const EdgeInsets.all(10.0),
          child: 
          Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                _categories.length,
                (int index) {
                  return ChoiceChip(
                    label: Text(_categories[index]),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                        _runFilter(actEntry);
                      });
                    },
                  );
                },
              ).toList(),
            ),),
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
          Expanded(
            child: ListView.builder(padding: const EdgeInsets.all(8),
            itemCount: _foundUsers.length,
            itemBuilder: (context, index) => CardBtn(title: _foundUsers[index]['name'], subtitle: _foundUsers[index]['category'], onPressed: () => showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),)
              /*itemBuilder: (context, index) =>Card(

              
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.album),
                        title: Text('The Enchanted Nightingale'),
                        subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('BUY TICKETS'),
                            onPressed: () {showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );},
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('LISTEN'),
                            onPressed: () {/* ... */},
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),*/
          )),
        ],
      )
      )
    );
  }
}