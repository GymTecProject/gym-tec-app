import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';

import 'package:gym_tec/components/ui/separators/item_separator.dart';

import 'package:gym_tec/routines/exercise_data.dart';
import 'package:gym_tec/routines/exercise_page.dart';

import '../components/ui/buttons/card_btn.dart';

class RoutineDay extends StatelessWidget {
  RoutineDay({Key? key}) : super(key: key);

  static const String date = 'MONDAY, SEPTEMBER 11';

  // Define una lista de datos para tus botones
  final List<ExerciseData> exercises = [
    ExerciseData(
        title: 'Caminadora Estacionaria',
        subtitle: 'Calentamiento',
        imgPath: 'assets/images/h1-1.png',
        url: 'url',
        comment: 'comment',
        category: 'category'),
    ExerciseData(
        title: 'Jalon Polea Prono',
        subtitle: 'Ejercicio 1',
        imgPath: 'assets/images/h1-1.png',
        url: 'url',
        comment: 'comment',
        category: 'category'),
    ExerciseData(
        title: 'Jalon Polea Supino',
        subtitle: 'Ejercicio 2',
        imgPath: 'assets/images/h1-1.png',
        url: 'url',
        comment: 'comment',
        category: 'category'),
    ExerciseData(
        title: 'Copa Tricep',
        subtitle: 'Ejercicio 3',
        imgPath: 'assets/images/h1-1.png',
        url: 'url',
        comment: 'comment',
        category: 'category'),
    ExerciseData(
        title: 'Jalon Mecate Triceps',
        subtitle: 'Ejercicio 4',
        imgPath: 'assets/images/h1-1.png',
        url: 'url',
        comment: 'comment',
        category: 'category'),
    ExerciseData(
        title: 'Jalon Barra Triceps',
        subtitle: 'Ejercicio 5',
        imgPath: 'assets/images/h1-1.png',
        url: 'url',
        comment: 'comment',
        category: 'category'),
    ExerciseData(
        title: 'Hombro militar',
        subtitle: 'Ejercicio 6',
        imgPath: 'assets/images/h1-1.png',
        url: 'url',
        comment: 'comment',
        category: 'category')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: ContentPadding(
                child: ListView.separated(
                  itemCount: exercises.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const ContextSeparator(), // Espacio entre botones
                  itemBuilder: (BuildContext context, int index) {
                    return CardBtn(
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
            ),
          ],
        ),
      ),
    );
  }
}
