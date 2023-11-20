import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/models/routines/routine_exercise.dart';
import 'package:gym_tec/pages/user/routines/exercise_page.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';

class RoutineDay extends StatefulWidget {
  final String title;
  final List<RoutineExercise> exercises;

  const RoutineDay({
    super.key,
    required this.title,
    required this.exercises
  });

  @override
  State<RoutineDay> createState() => _RoutineDayState();
}

class _RoutineDayState extends State<RoutineDay> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ContentPadding(
                child: ListView.separated(
                  itemCount: widget.exercises.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const ContextSeparator(), // Espacio entre botones
                  itemBuilder: (BuildContext context, int index) {
                    return CardBtn(
                      title: widget.exercises[index].name,
                      subtitle: widget.exercises[index].category,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ExercisePage(
                                title: widget.exercises[index].name,
                                subtitle: widget.exercises[index].category,
                                series: widget.exercises[index].series,
                                repetitions: widget.exercises[index].repetitions,
                                url: widget.exercises[index].url,
                                comment: widget.exercises[index].comment,
                                category: widget.exercises[index].category,
                                weight: widget.exercises[index].weight
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
