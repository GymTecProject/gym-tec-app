class UserProtectedData {
  String id;
  String email;
  String phoneNumber;
  List<String> medicalConditions;
  String objective;

  UserProtectedData({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.medicalConditions,
    required this.objective,
  });

  factory UserProtectedData.fromMap(Map<String, dynamic> map) =>
      UserProtectedData(
        id: map['uid'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        medicalConditions: (map['medicalConditions'] as List).map((item) => item as String).toList(),
        objective: map['objective'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'phoneNumber': phoneNumber,
        'medicalConditions': medicalConditions,
        'objective': objective,
      };
}
