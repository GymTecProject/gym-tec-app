import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/models/routines/routine_workout.dart';

class RoutineData {
  Timestamp date;
  String clientId;
  String trainerId;
  List<String> comments;
  List<Workout> workout;
  Timestamp expirationDate;

  RoutineData({
    required this.date,
    required this.clientId,
    required this.trainerId,
    required this.comments,
    required this.workout,
    required this.expirationDate,
  });

  factory RoutineData.fromJson(Map<String, dynamic> map) {
    return RoutineData(
      date: map['date'],
      clientId: map['clientId'],
      trainerId: map['trainerId'],
      comments: map['comments'],
      workout: (map['workout'] as List)
          .map((item) => Workout.fromJson(item))
          .toList(),
      expirationDate: map['expirationDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'clientId': clientId,
      'trainerId': trainerId,
      'comments': comments,
      'workout': workout.map((item) => item.toJson()).toList(),
      'expirationDate': expirationDate,
    };
  }
}
