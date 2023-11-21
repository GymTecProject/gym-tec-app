import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_tec/models/excercises/exercise.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public_private.dart';
import 'package:gym_tec/models/measures/measurements.dart';
import 'package:gym_tec/services/db/firebase_firestore_service.dart';

void main() async {
  final fbFakeInstance = FakeFirebaseFirestore();
  await fbFakeInstance
      .collection('users')
      .doc('testUser')
      .set({'name': 'Juan', 'sex': 'male', 'expirationDate': Timestamp.now()});
  final fakeDbService = DatabaseFirebase(firebaseInstance: fbFakeInstance);
  String excerciseTestId = '';
  test('Should return userMeasurement object', () async {
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
    final userMeasurement =
        await fakeDbService.getUserLatestMeasurement('testUser');
    expect(userMeasurement, isA<UserMeasurement>());
  });
  test('Should return null if measurement obj is incomplete', () async {
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
    });
    final userMeasurement =
        await fakeDbService.getUserLatestMeasurement('testUser');
    expect(userMeasurement, isNull);
  });
  test('Should return UserMeasurement with int values', () async {
    await fbFakeInstance
        .collection('users')
        .doc('testUser')
        .collection('measurements')
        .add({
      'date': Timestamp.fromDate(DateTime.now()),
      'birthdate': Timestamp.fromDate(DateTime.utc(1999, 12, 31)),
      'age': 10,
      'water': 10,
      'fatPercentage': 10,
      'skeletalMuscle': 10,
      'muscleMass': 10,
      'height': 10,
      'weight': 10,
      'viceralFatLevel': 10
    });

    final userMeasurement =
        await fakeDbService.getUserLatestMeasurement('testUser');
    expect(userMeasurement, isA<UserMeasurement>());
  });

  test(
      'User PublicPrivate Data should not be null and contain public and private data',
      () async {
    await fbFakeInstance
        .collection('users')
        .doc('testUser')
        .collection('private')
        .doc('data')
        .set({'accountType': 'administrator'});

    final List<UserPublicPrivateData>? userPublicPrivateData =
        await fakeDbService.getAllUsersPublicPrivateData();
    expect(userPublicPrivateData, isNotNull);
    expect(userPublicPrivateData![0].publicData.id, 'testUser');
    expect(userPublicPrivateData[0].privateData.accountType,
        AccountType.administrator);
  });

  test('Should create a new social document if it does not exist', () async {
    final doc = await fbFakeInstance.collection('social').doc('links').get();
    expect(doc.exists, false);
    await fakeDbService.addSocialLink({
      'facebook': 'facebook.com',
      'instagram': 'instagram.com',
      'twitter': 'twitter.com',
      'youtube': 'youtube.com',
      'tiktok': 'tiktok.com',
    });
    final doc2 = await fbFakeInstance.collection('social').doc('links').get();
    expect(doc2.exists, true);
    expect(doc2.data()!['facebook'], 'facebook.com');
    expect(doc2.data()!['instagram'], 'instagram.com');
    expect(doc2.data()!['twitter'], 'twitter.com');
    expect(doc2.data()!['youtube'], 'youtube.com');
    expect(doc2.data()!['tiktok'], 'tiktok.com');
  });

  test('Should create a new exercise', () async {
    Exercise exercise = Exercise(name: 'test', url: 'test', category: 'test');
    await fakeDbService.addExcercise(exercise);

    final doc = await fbFakeInstance
        .collection('exercises')
        .where('name', isEqualTo: 'test')
        .get();
    expect(doc.docs[0].data(), isNotNull);
  });

  test('Should update an exercise', () async {
    final newDoc = await fbFakeInstance.collection('exercises').add({
      'name': 'test',
      'url': 'test',
      'category': 'test',
    });
    Exercise exercise =
        Exercise(name: 'test', url: 'test', category: 'updated');

    await fakeDbService.updateExercise(newDoc.id, exercise);
    final doc2 =
        await fbFakeInstance.collection('exercises').doc(newDoc.id).get();
    final data2 = doc2.data();
    expect(data2!['category'], 'updated');
  });
}
