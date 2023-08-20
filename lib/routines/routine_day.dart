import 'package:flutter/material.dart';

import 'package:gym_tec/components/ui/buttons/RoutineButton.dart';

import 'package:gym_tec/routines/exercise_data.dart';
import 'package:gym_tec/routines/exercise_page.dart';

class RoutineDay extends StatelessWidget {
  RoutineDay({Key? key}) : super(key: key);

  static const String date = 'MONDAY, SEPTEMBER 11';

  // Define una lista de datos para tus botones
  final List<ExerciseData> exercises = [
    ExerciseData(title: 'Caminadora Estacionaria',   subtitle: 'Calentamiento',  imgPath: 'assets/images/h1-1.png', url: 'url', comment: 'comment', category: 'category'),
    ExerciseData(title: 'Jalon Polea Prono',         subtitle: 'Ejercicio 1',    imgPath: 'assets/images/h1-1.png', url: 'url', comment: 'comment', category: 'category'),
    ExerciseData(title: 'Jalon Polea Supino',        subtitle: 'Ejercicio 2',    imgPath: 'assets/images/h1-1.png', url: 'url', comment: 'comment', category: 'category'),
    ExerciseData(title: 'Copa Tricep',               subtitle: 'Ejercicio 3',    imgPath: 'assets/images/h1-1.png', url: 'url', comment: 'comment', category: 'category'),
    ExerciseData(title: 'Jalon Mecate Triceps',      subtitle: 'Ejercicio 4',    imgPath: 'assets/images/h1-1.png', url: 'url', comment: 'comment', category: 'category'),
    ExerciseData(title: 'Jalon Barra Triceps',       subtitle: 'Ejercicio 5',    imgPath: 'assets/images/h1-1.png', url: 'url', comment: 'comment', category: 'category'),
    ExerciseData(title: 'Hombro militar',            subtitle: 'Ejercicio 6',    imgPath: 'assets/images/h1-1.png', url: 'url', comment: 'comment', category: 'category')

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Aquí puedes personalizar el AppBar según tus necesidades
        title: Text('Your daily routines:'),
        // Agrega un botón de regreso en la AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Agrega aquí la lógica para regresar a la pantalla de inicio
            // Puedes utilizar Navigator.pop() para regresar a la pantalla anterior
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 50.0),
              child: Text(
                'Here is your routine:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: ListView.separated(
                itemCount: exercises.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 16.0), // Espacio entre botones
                itemBuilder: (BuildContext context, int index) {
                  return RoutineButton(
                    title: exercises[index].title,
                    subtitle: exercises[index].subtitle,
                    imgPath: exercises[index].imgPath,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ExercisePage(
                              title: exercises[index].title,
                              subtitle: exercises[index].subtitle,
                              imgPath: exercises[index].imgPath,
                              url: exercises[index].url,
                              comment: exercises[index].comment,
                              category: exercises[index].category,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
class RoutinePage extends StatelessWidget {
  const RoutinePage({Key? key}) : super(key: key);

  static const String date = 'MONDAY, SEPTEMBER 11';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Aquí puedes personalizar el AppBar según tus necesidades
        title: Text('Your daily routines:'),
        // Agrega un botón de regreso en la AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Agrega aquí la lógica para regresar a la pantalla de inicio
            // Puedes utilizar Navigator.pop() para regresar a la pantalla anterior
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 50.0),
              child: Text(
                'Here is your routine:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                RoutineButton(
                  title: 'Dia 1', 
                  subtitle: 'Tren inferior', 
                  imgPath: 'assets/images/h1-1.png', 
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const RoutineDay();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
*/
/*
class RoutineDay extends StatelessWidget {
  const RoutineDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Aquí puedes personalizar el AppBar según tus necesidades
        title: Text('Your today\'s routine:'),
        // Agrega un botón de regreso en la AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Agrega aquí la lógica para regresar a la pantalla de inicio
            // Puedes utilizar Navigator.pop() para regresar a la pantalla anterior
            Navigator.pop(context);
          },
        ),
      ),
    );
    
  }
}

*/