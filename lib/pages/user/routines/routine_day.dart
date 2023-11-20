import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/models/routines/routine_exercise.dart';
import 'package:gym_tec/pages/user/routines/exercise_page.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';

class RoutineDay extends StatefulWidget {
  final String title;
  final List<RoutineExercise> exercises;
  final int workoutIndex;
  final Timestamp date;

  const RoutineDay({
    super.key,
    required this.title,
    required this.exercises,
    required this.workoutIndex,
    required this.date,
  });

  @override
  State<RoutineDay> createState() => _RoutineDayState();
}

class _RoutineDayState extends State<RoutineDay> {
  
  void _createExercisePage(int index) async{
      final updatedWeight = await Navigator.of(context).push(
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
              weight: widget.exercises[index].weight,
              workoutIndex: widget.workoutIndex,
              exerciseIndex: index,
              date: widget.date
            );
          },
        ),
      );
    if (updatedWeight != null) {
      setState(() {
        widget.exercises[index].weight = updatedWeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
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
                        _createExercisePage(index);
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
