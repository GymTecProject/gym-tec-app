class UserProtectedData {
  String email;
  String phoneNumber;
  List<String> medicalConditions;
  String objective;

  UserProtectedData({    
    required this.email,
    required this.phoneNumber,
    required this.medicalConditions,
    required this.objective,
    });

  factory UserProtectedData.fromMap(Map<String, dynamic> map) => UserProtectedData(
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        medicalConditions: map['medicalConditions']??[],
        objective: map['objective']??'',
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'phoneNumber': phoneNumber,
        'medicalConditions': medicalConditions,
        'objective': objective,
  };
}
