import 'package:cloud_firestore/cloud_firestore.dart';

class RoutineData {
  Timestamp date;
  String clientId;
  String trainerId;
  List<String> comments;
  // List<String> workout;
  Timestamp expirationDate;

  RoutineData({
    required this.date,
    required this.clientId,
    required this.trainerId,
    required this.comments,
    // required this.workout,
    required this.expirationDate,
  });

  factory RoutineData.fromMap(Map<String, dynamic> map) {
    return RoutineData(
      date: map['date'],
      clientId: map['clientId'],
      trainerId: map['trainerId'],
      comments: map['comments'],
      // workout: map['workout'],
      expirationDate: map['expirationDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'clientId': clientId,
      'trainerId': trainerId,
      'comments': comments,
      // 'workout': workout,
      'expirationDate': expirationDate,
    };
  }
}
