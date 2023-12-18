import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/measures/measurements.dart';
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
  double? fatMass;
  double? fatPercentage;
  double? height;
  double? muscleMass;
  double? weight;
  double? skeletalMuscle;
  double? water;
  double? viceralFatLevel;

  List<Widget> buttons = [];

  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  void saveMeasure(date, birthdate, fatPercentage, height, muscleMass, weight,
      water, age, viceralFatLevel, skeletalMuscle) async {
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
        skeletalMuscle: skeletalMuscle);
    try {
      await dbService.createUserMeasurement(clientId, measurementData.toJson());
      if (!mounted) return;
      Navigator.pop(context, 'Medida creada con éxito');
    } catch (e) {
      Navigator.pop(context, 'Error al crear nueva medida');
    }
  }

  Widget _buildNumberField(String label, void Function(String?) onSaved) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder()),
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
        if (label == 'Altura') {
          if (n < 65 || n > 250) {
            return 'La altura es en centimetros, por favor revise el número ingresado.';
          }
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Medidas'),
      ),
      body: ContentPadding(
        child: Card(
          color: Theme.of(context).colorScheme.surface,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                _buildNumberField('Masa corporal',
                    (value) => setState(() => fatMass = double.tryParse(value!))),
                const SizedBox(height: 16.0),
                _buildNumberField(
                    'Porcentaje de grasa corporal',
                    (value) =>
                        setState(() => fatPercentage = double.tryParse(value!))),
                const SizedBox(height: 16.0),
                _buildNumberField('Altura (cm)',
                    (value) => setState(() => height = double.tryParse(value!))),
                const SizedBox(height: 16.0),
                _buildNumberField(
                    'Masa muscular',
                    (value) =>
                        setState(() => muscleMass = double.tryParse(value!))),
                const SizedBox(height: 16.0),
                _buildNumberField('Peso',
                    (value) => setState(() => weight = double.tryParse(value!))),
                const SizedBox(height: 16.0),
                _buildNumberField('Edad',
                    (value) => setState(() => age = int.tryParse(value!))),
                const SizedBox(height: 16.0),
                _buildNumberField(
                    'Masa ósea',
                    (value) =>
                        setState(() => skeletalMuscle = double.tryParse(value!))),
                const SizedBox(height: 16.0),
                _buildNumberField(
                    'Grasa visceral',
                    (value) => setState(
                        () => viceralFatLevel = double.tryParse(value!))),
                const SizedBox(height: 16.0),
                _buildNumberField('Porcentaje de agua',
                    (value) => setState(() => water = double.tryParse(value!))),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    saveMeasure(
                        Timestamp.now(),
                        Timestamp.fromDate(DateTime.utc(1999, 12, 31)),
                        fatPercentage,
                        height,
                        muscleMass,
                        weight,
                        water,
                        age,
                        viceralFatLevel,
                        skeletalMuscle);
                  }
                },
        child: const Icon(Icons.save),
      ),
    );
  }
}
