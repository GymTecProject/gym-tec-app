import 'package:flutter/material.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class ViewMeasures extends StatefulWidget {
  final List<UserMeasurement>? m;

  const ViewMeasures({super.key, required this.m});

  @override
  State<ViewMeasures> createState() => _ViewMeasuresState();
}

class _ViewMeasuresState extends State<ViewMeasures> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  List<UserMeasurement> _userMeasurement = [];
  UserMeasurement? previousMeasurement;

  @override
  void initState() {
    super.initState();
    _fetchMeasuresData();
  }

  void _fetchMeasuresData() async {
    if (widget.m == null) {
      print("USERMEASUREMENT IS NULL");
      _userMeasurement = [];
      return;
    } else {
      print("UserMeasurements len: ${widget.m?.length}");
      print("Last User's age: ${widget.m?.last.age}");
      for (int i = 0; i < widget.m!.length; i++) {
        print(widget.m?[i].muscleMass);
      }
    }
    setState(() {
      _userMeasurement = widget.m!;
    });
  }

  void _showDateMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _userMeasurement.length,
          itemBuilder: (context, index) {
            DateTime date = _userMeasurement[index]
                .date
                .toDate(); // Asume que date es un Timestamp
            String formattedDate = "${date.day}/${date.month}/${date.year}";

            return ListTile(
              title: Text(formattedDate),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  previousMeasurement = _userMeasurement[index];
                });
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_userMeasurement.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ver Medidas',
            style: TextStyle(
              fontSize: 24, // Tamaño de fuente más grande
              fontWeight: FontWeight.bold, // Fuente en negrita
            ),
          ),
        ),
        body: const Center(
          child: Text('No hay suficientes datos para comparar.'),
        ),
      );
    }

    final lastMeasurement = _userMeasurement.first;
    if (_userMeasurement.length < 2) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ver Medidas',
            style: TextStyle(
              fontSize: 24, // Tamaño de fuente más grande
              fontWeight: FontWeight.bold, // Fuente en negrita
            ),
          ),
        ),
        body: Padding( // Aplicar Padding al ListView
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Relleno solo horizontal
        child: ListView(
          children: [
              _showSingleMeasurement('Masa Grasa', lastMeasurement.fatPercentage, 'kg.'),
              _showSingleMeasurement('Altura', lastMeasurement.height, 'm.'),
              _showSingleMeasurement('Masa muscular', lastMeasurement.muscleMass, 'kg.'),
              _showSingleMeasurement('Peso', lastMeasurement.weight, 'kg.'),
              _showSingleMeasurement('Porcentaje de agua', lastMeasurement.water, '%'),
              _showSingleMeasurement('Porcentaje de grasa corporal', lastMeasurement.fatPercentage, '%'),
              _showSingleMeasurement('Grasa visceral', lastMeasurement.viceralFatLevel, '%'),
              _showSingleMeasurement('Masa osea', lastMeasurement.skeletalMuscle, 'kg.')
            ],
        ),
      )
    );
  }

    final previousMeasurement = _userMeasurement[1];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Ver Medidas',
            style: TextStyle(
              fontSize: 24, // Tamaño de fuente más grande
              fontWeight: FontWeight.bold, // Fuente en negrita
            ),
          ),
        
        actions: [
          ElevatedButton(
            onPressed: () => _showDateMenu(context),
            child: Text('Comparar medidas'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Relleno
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          _createComparisonCard('Masa Grasa', previousMeasurement.fatPercentage,lastMeasurement.fatPercentage, 'kg.'),
          _createComparisonCard('Altura', previousMeasurement.height, lastMeasurement.height, 'm.'),
          _createComparisonCard('Masa muscular', previousMeasurement.muscleMass,lastMeasurement.muscleMass, 'kg.'),
          _createComparisonCard('Peso', previousMeasurement.weight, lastMeasurement.weight, 'kg'),
          _createComparisonCard('Porcentaje de grasa corporal', previousMeasurement.fatPercentage, lastMeasurement.fatPercentage, '%'),
          _createComparisonCard('Porcentaje de agua', previousMeasurement.water, lastMeasurement.water, '%'),
          _createComparisonCard('Grasa visceral',previousMeasurement.viceralFatLevel,lastMeasurement.viceralFatLevel, '%'),
          _createComparisonCard('Masa osea', previousMeasurement.skeletalMuscle,lastMeasurement.skeletalMuscle, 'kg.')
        ],
      ),
    );
  }

Widget _showSingleMeasurement(String title, num? currentValue, String parameter) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Ajustado para centrar el título
        children: [
          Text(
            title,
            textAlign: TextAlign.center, // Ajustado para centrar el texto
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$currentValue $parameter',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

Widget _createComparisonCard(String title, num? previousValue, num? currentValue, String parameter) {
  final difference = currentValue != null && previousValue != null
      ? currentValue - previousValue
      : null;

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Ajustado para centrar el título
        children: [
          Text(
            title,
            textAlign: TextAlign.center, // Ajustado para centrar el texto
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Antes: $previousValue $parameter',
                style: const TextStyle(fontSize: 16),
              ),Text(
                'Ahora: $currentValue $parameter',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Diferencia: $difference $parameter',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}
