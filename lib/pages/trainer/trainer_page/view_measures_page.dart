import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/card_btn.dart';
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

  List<UserMeasurement> _UserMeasurement = [];
  UserMeasurement? previousMeasurement;

  @override
  void initState() {
    super.initState();
    _fetchMeasuresData();
  }

  void _fetchMeasuresData() async {
    if (widget.m == null) {
      print("USERMEASUREMENT IS NULL");
      _UserMeasurement = [];
      return;
    } else {
      print("UserMeasurements len: ${widget.m?.length}");
      print("Last User's age: ${widget.m?.last.age}");
      for (int i = 0; i < widget.m!.length; i++) {
        print(widget.m?[i].muscleMass);
      }
    }
    setState(() {
      _UserMeasurement = widget.m!;
    });
  }

  void _showDateMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _UserMeasurement.length,
          itemBuilder: (context, index) {
            DateTime date = _UserMeasurement[index]
                .date
                .toDate(); // Asume que date es un Timestamp
            String formattedDate = "${date.day}/${date.month}/${date.year}";

            return ListTile(
              title: Text(formattedDate),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  previousMeasurement = _UserMeasurement[index];
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
    if (_UserMeasurement.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('View Measures'),
        ),
        body: const Center(
          child: Text('No hay suficientes datos para comparar.'),
        ),
      );
    }

    final lastMeasurement = _UserMeasurement.first;
    if (_UserMeasurement.length < 2) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('View Measures'),
        ),
        body: ListView(
          children: [
            _showSingleMeasurement('Masa Grasa', lastMeasurement.fatPercentage),
            _showSingleMeasurement('Altura', lastMeasurement.height),
            _showSingleMeasurement('Masa muscular', lastMeasurement.muscleMass),
            _showSingleMeasurement('Peso', lastMeasurement.weight),
            _showSingleMeasurement('Porcentaje de agua', lastMeasurement.water),
            _showSingleMeasurement(
                'Grasa visceral', lastMeasurement.viceralFatLevel),
            _showSingleMeasurement('Masa osea', lastMeasurement.skeletalMuscle)
          ],
        ),
      );
    }

    final previousMeasurement = _UserMeasurement[1];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medidas de'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _showDateMenu(context),
          ),
        ],
      ),
      body: ListView(
        children: [
          _createComparisonCard('Masa Grasa', previousMeasurement.fatPercentage,
              lastMeasurement.fatPercentage),
          _createComparisonCard(
              'Altura', previousMeasurement.height, lastMeasurement.height),
          _createComparisonCard('Masa muscular', previousMeasurement.muscleMass,
              lastMeasurement.muscleMass),
          _createComparisonCard(
              'Peso', previousMeasurement.weight, lastMeasurement.weight),
          _createComparisonCard('Porcentaje de agua', previousMeasurement.water,
              lastMeasurement.water),
          _createComparisonCard(
              'Grasa visceral',
              previousMeasurement.viceralFatLevel,
              lastMeasurement.viceralFatLevel),
          _createComparisonCard('Masa osea', previousMeasurement.skeletalMuscle,
              lastMeasurement.skeletalMuscle)
        ],
      ),
    );
  }

  Widget _showSingleMeasurement(String title, num? currentValue) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Fecha actual: $currentValue',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createComparisonCard(
      String title, num? previousValue, num? currentValue) {
    final difference = currentValue != null && previousValue != null
        ? currentValue - previousValue
        : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
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
                  'Fecha actual: $currentValue',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Fecha anterior: $previousValue',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Diferencia: $difference',
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
