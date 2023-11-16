import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/services/db/firebase_firestore_service.dart';

void main() async {
  final fbFakeInstance = FakeFirebaseFirestore();
  await fbFakeInstance
      .collection('users')
      .doc('testUser')
      .set({'name': 'Juan', 'lastName': 'Perez', 'email': 'test@email.com'});
  await fbFakeInstance
      .collection('users')
      .doc('testUser')
      .collection('measurements')
      .add({
    'date': Timestamp.fromDate(DateTime.now()),
    'birthdate': Timestamp.fromDate(DateTime.utc(1999, 12, 31)),
    'age': 10,
    'water': 10.0,
    'fatPercentage': 10.0,
    'skeletalMuscle': 10.0,
    'muscleMass': 10.0,
    'height': 10.0,
    'weight': 10.0,
    'viceralFatLevel': 10,
  });
  final fakeDbService = DatabaseFirebase(firebaseInstance: fbFakeInstance);

  test('Should return userMeasurement object', () async {
    final userMeasurement =
        await fakeDbService.getUserLatestMeasurement('testUser');
    expect(userMeasurement, isA<UserMeasurement>());
  });
}
