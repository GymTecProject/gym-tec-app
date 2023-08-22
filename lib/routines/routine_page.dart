import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/routines/routine_data.dart';
import 'package:gym_tec/routines/routine_day.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

  static const String date = 'MONDAY, SEPTEMBER 11';

  // Define una lista de datos para tus botones
  static const List<RoutineData> routines = [
    RoutineData(
        title: 'Día 1',
        subtitle: 'Tren inferior',
        imgPath: 'assets/images/h1-1.png'),
    RoutineData(
        title: 'Día 2',
        subtitle: 'Tren superior',
        imgPath: 'assets/images/h1-1.png'),
    RoutineData(
        title: 'Día 3',
        subtitle: 'Tren superior',
        imgPath: 'assets/images/h1-1.png')
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
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Here is your routine:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: ContentPadding(
                child: Column(
                  children: [
                    ListView.separated(
                      itemCount: routines.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const ContextSeparator(),
                      itemBuilder: (BuildContext context, int index) {
                        return CardBtn(
                          title: routines[index].title,
                          subtitle: routines[index].subtitle,
                          imgPath: routines[index].imgPath,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RoutineDay();
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
