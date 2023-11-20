import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/view_measurement_comparison_card.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/components/ui/buttons/view_single_measurement_card.dart';
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
  UserMeasurement? lastMeasurement;

  @override
  void initState() {
    super.initState();
    _userMeasurement = widget.m!;
    lastMeasurement = _userMeasurement.first;
    previousMeasurement =
        _userMeasurement.length > 1 ? _userMeasurement[1] : lastMeasurement;
  }

  String getMonth(int month) {
    if (month == 1) {
      return "Enero";
    } else if (month == 2) {
      return "Febrero";
    } else if (month == 3) {
      return "Marzo";
    } else if (month == 4) {
      return "Abril";
    } else if (month == 5) {
      return "Mayo";
    } else if (month == 6) {
      return "Junio";
    } else if (month == 7) {
      return "Julio";
    } else if (month == 8) {
      return "Agosto";
    } else if (month == 9) {
      return "Ssetiembre";
    } else if (month == 10) {
      return "Octubre";
    } else if (month == 11) {
      return "Noviembre";
    } else {
      return "Diciembre";
    }
  }

  void _showDateMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _userMeasurement.length,
          itemBuilder: (context, index) {
            if (index == 0) return Container();
            DateTime date = _userMeasurement[index].date.toDate();
            String formattedDate =
                "${date.day} de ${getMonth(date.month)} del ${date.year}";

            return ListTile(
              title: Text(
                formattedDate,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
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
          body: Padding(
            // Aplicar Padding al ListView
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0), // Relleno solo horizontal
            child: ListView(
              children: [
                SingleMeasurementCard(
                    title: 'Masa grasa',
                    currentValue: lastMeasurement!.fatPercentage,
                    parameter: 'kg.'),
                SingleMeasurementCard(
                    title: 'Altura',
                    currentValue: lastMeasurement!.height,
                    parameter: 'm.'),
                SingleMeasurementCard(
                    title: 'Masa muscular',
                    currentValue: lastMeasurement!.muscleMass,
                    parameter: 'kg.'),
                SingleMeasurementCard(
                    title: 'Peso',
                    currentValue: lastMeasurement!.weight,
                    parameter: 'kg.'),
                SingleMeasurementCard(
                    title: 'Porcentaje de agua',
                    currentValue: lastMeasurement!.water,
                    parameter: 'kg.'),
                SingleMeasurementCard(
                    title: 'Porcentaje de grasa corporal',
                    currentValue: lastMeasurement!.fatPercentage,
                    parameter: 'kg.'),
                SingleMeasurementCard(
                    title: 'Porcentaje de Grasa visceral',
                    currentValue: lastMeasurement!.viceralFatLevel,
                    parameter: 'kg.'),
                SingleMeasurementCard(
                    title: 'Masa ósea',
                    currentValue: lastMeasurement!.skeletalMuscle,
                    parameter: 'kg.')
              ],
            ),
          ));
    }

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
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10), // Relleno
            ),
            child: const Text('Comparar medidas'),
          ),
        ],
      ),
      body: ListView(
        children: [
          MeasurementComparisonCard(
              title: 'Masa Grasa',
              previousValue: previousMeasurement!.fatPercentage,
              currentValue: lastMeasurement!.fatPercentage,
              parameter: 'kg.'),
          MeasurementComparisonCard(
              title: 'Altura',
              previousValue: previousMeasurement!.height,
              currentValue: lastMeasurement!.height,
              parameter: 'm.'),
          MeasurementComparisonCard(
              title: 'Masa muscular',
              previousValue: previousMeasurement!.muscleMass,
              currentValue: lastMeasurement!.muscleMass,
              parameter: 'kg.'),
          MeasurementComparisonCard(
              title: 'Peso',
              previousValue: previousMeasurement!.weight,
              currentValue: lastMeasurement!.weight,
              parameter: 'kg.'),
          MeasurementComparisonCard(
              title: 'Porcentaje de grasa corporal',
              previousValue: previousMeasurement!.fatPercentage,
              currentValue: lastMeasurement!.fatPercentage,
              parameter: '%'),
          MeasurementComparisonCard(
              title: 'Porcentaje de agua',
              previousValue: previousMeasurement!.water,
              currentValue: lastMeasurement!.water,
              parameter: '%'),
          MeasurementComparisonCard(
              title: 'Porcentaje de Grasa visceral',
              previousValue: previousMeasurement!.viceralFatLevel,
              currentValue: lastMeasurement!.viceralFatLevel,
              parameter: '%'),
          MeasurementComparisonCard(
              title: 'Masa ósea',
              previousValue: previousMeasurement!.skeletalMuscle,
              currentValue: lastMeasurement!.skeletalMuscle,
              parameter: 'kg.')
        ],
      ),
    );
  }
}
