
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
    
    final difference = previousValue != null? currentValue - previousValue : null;

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
                Column(
                  children: [
                    const Text('Antes'),
                    Text(
                      '$previousValue $parameter',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Ahora'),
                    Text(
                      '$currentValue $parameter',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Diferencia'),
                    Text(
                      difference != null
                          ? '$difference $parameter'
                          : 'N/A',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
