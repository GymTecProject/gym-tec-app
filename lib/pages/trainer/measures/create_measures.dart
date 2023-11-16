import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/measures/measures_data.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class CreateMeasuresPage extends StatefulWidget {
  final String clientId;

  const CreateMeasuresPage({super.key, required this.clientId});

  @override
  State<CreateMeasuresPage> createState() => _CreateMeasuresPageState();
}

class _CreateMeasuresPageState extends State<CreateMeasuresPage> {
  final _formKey = GlobalKey<FormState>();

  int? age;
  double? fatMass; // Porcentaje de masa corporal
  double? fatPercentage; // Porcentaje de grasa corporal
  double? height;
  double? muscleMass; // Porcentaje de masa muscular
  double? weight;
  double? skeletalMuscle;
  double? weiviceralFatLevelght;
  double? water;
  double? viceralFatLevel;

  late final MeasurementData measures;

  List<Widget> buttons = [];

  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  void saveMeasure(
      date, birthdate, fatPercentage, height, muscleMass, weight, water, age, viceralFatLevel, skeletalMuscle) async {
    final clientId = widget.clientId;

    final measurementData = UserMeasurement(
      date: Timestamp.now(),
      birthdate: Timestamp.fromDate(DateTime.utc(1999, 12, 31)),
      fatPercentage: fatPercentage,
      height: height,
      muscleMass: muscleMass,
      weight: weight,
      water: water,
      age: age,
      viceralFatLevel: viceralFatLevel,
      skeletalMuscle: skeletalMuscle  
    );
    try {
      await dbService.createUserMeasurement(clientId, measurementData.toJson());
      if (!mounted) return;
      Navigator.pop(context, 'Rutina creada con éxito');
    } catch (e) {
      Navigator.pop(context, 'Error al crear la rutina');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Medidas'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            _buildNumberField('Masa corporal',
                (value) => setState(() => fatMass = double.tryParse(value!))),
            _buildNumberField('Porcentaje de grasa corporal',
                (value) => setState(() => fatPercentage = double.tryParse(value!))),
            _buildNumberField('Altura',
                (value) => setState(() => height = double.tryParse(value!))),
            _buildNumberField('Masa muscular',
                (value) =>setState(() => muscleMass = double.tryParse(value!))),
            _buildNumberField('Peso',
                (value) => setState(() => weight = double.tryParse(value!))),
            _buildNumberField('Edad',
                (value) =>setState(() => age = int.tryParse(value!))),
            _buildNumberField('Masa ósea',
                (value) =>setState(() => skeletalMuscle = double.tryParse(value!))),
                _buildNumberField('Grasa visceral',
                (value) =>setState(() => viceralFatLevel = double.tryParse(value!))),
            _buildNumberField('Porcentaje de agua',
                (value) =>setState(() => water = double.tryParse(value!))),
            ElevatedButton(
              child: const Text('Registrar nuevas medidas'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  saveMeasure(
                      Timestamp.now(), Timestamp.fromDate(DateTime.utc(1999, 12, 31)), fatPercentage, height, muscleMass, weight, water, age, viceralFatLevel, skeletalMuscle);
                  print("guardaos pescaos");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberField(String label, void Function(String?) onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese un valor';
        }
        // Verifica si el valor es un número
        final n = num.tryParse(value);
        if (n == null) {
          return 'Por favor ingrese un valor numérico válido';
        }
        return null;
      },
    );
  }
}
