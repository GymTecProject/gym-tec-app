import 'package:flutter/material.dart';

class CreateMeasuresPage extends StatefulWidget {
  const CreateMeasuresPage({super.key});
  
  @override
  State<CreateMeasuresPage> createState() => _CreateMeasuresPageState();
  
  // _CreateMeasuresPageState createState() => _CreateMeasuresPageState();
}

class _CreateMeasuresPageState extends State<CreateMeasuresPage> {
  final _formKey = GlobalKey<FormState>();

  int? age;
  double? fatMass; // Porcentaje de masa corporal
  double? fatPercentage; // Porcentaje de grasa corporal
  double? height;
  double? muscleMass; // Porcentaje de masa muscular
  double? weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Medidas'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            _buildNumberField('Edad', (value) => setState(() => age = int.tryParse(value!))),
            _buildNumberField('Masa corporal', (value) => setState(() => fatMass = double.tryParse(value!))),
            _buildNumberField('Porcentaje de grasa corporal', (value) => setState(() => fatPercentage = double.tryParse(value!))),
            _buildNumberField('Altura', (value) => setState(() => height = double.tryParse(value!))),
            _buildNumberField('Masa muscular', (value) => setState(() => muscleMass = double.tryParse(value!))),
            _buildNumberField('Peso', (value) => setState(() => weight = double.tryParse(value!))),
            ElevatedButton(
              child: Text('Registrar nuevas medidas'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
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