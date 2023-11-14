class MeasurementData {

  int age;
  double fatMass; // Porcentaje de masa corporal
  double fatPercentage; // Porcentaje de grasa corporal
  double height;
  double muscleMass; // Porcentaje de masa muscular
  double weight;


  MeasurementData({
    required this.age,
    required this.fatMass,
    required this.fatPercentage,
    required this.height,
    required this.muscleMass,
    required this.weight,
  });

  factory MeasurementData.fromJson(Map<String, dynamic> map) {
    return MeasurementData(
      age: map['age'],
      fatMass: map['fatMass'],
      fatPercentage: map['fatPercentage'],
      height: map['height'],
      muscleMass: map['muscleMass'],
      weight: map['weight']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'fatMass': fatMass,
      'fatPercentage': fatPercentage,
      'height': height,
      'muscleMass': muscleMass,
      'weight': weight,
    };
  }
}
