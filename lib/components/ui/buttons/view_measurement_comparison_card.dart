import 'package:flutter/material.dart';

class MeasurementComparisonCard extends StatelessWidget {
  final String title;
  final num previousValue;
  final num currentValue;
  final String parameter;

  const MeasurementComparisonCard({
    Key? key,
    required this.title,
    required this.previousValue,
    required this.currentValue,
    required this.parameter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                ),
                Text(
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
