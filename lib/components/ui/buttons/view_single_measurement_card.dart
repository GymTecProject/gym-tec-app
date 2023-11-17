import 'package:flutter/material.dart';

class SingleMeasurementCard extends StatelessWidget {
  final String title;
  final num? currentValue;
  final String parameter;

  const SingleMeasurementCard({
    Key? key,
    required this.title,
    required this.currentValue,
    required this.parameter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
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
}
