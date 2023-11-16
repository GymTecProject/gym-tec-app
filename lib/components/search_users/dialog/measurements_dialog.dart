import 'package:flutter/material.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MeasurementsDialog extends StatefulWidget {
  final String name;
  final UserMeasurement? m;

  const MeasurementsDialog({super.key, required this.name, required this.m});

  @override
  State<MeasurementsDialog> createState() => _MeasurementsDialog();
}

class _MeasurementsDialog extends State<MeasurementsDialog> {
  @override
  Widget build(BuildContext context) {
    // Define an AlertDialog variable
    AlertDialog alertDialog;

    if (widget.m != null) {
      alertDialog = AlertDialog(
        title: Text(widget.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text("Edad: ${widget.m?.age} años"),
            Text("Estatura: ${widget.m?.height} cm"),
            Text("Peso: ${widget.m?.weight} kg"),
            Text("Masa Muscular: ${widget.m?.muscleMass} kg"),
            Text("Porcentaje de Grasa: ${widget.m?.fatPercentage}%"),
            Text("Agua: ${widget.m?.water}%"),
            Text("Músculo esquelético: ${widget.m?.skeletalMuscle} kg"),
            Text("Nivel de grasa visceral: ${widget.m?.viceralFatLevel}"),
          ],
        ),
        actions: const [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      );
    } else {
      alertDialog = const AlertDialog(
        title: Text("Name"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text("User added measurements"),
            SizedBox(height: 10),
            Text("Edad: xx"),
            Text("Estatura: xx cm"),
            Text("Peso: xx kg"),
            Text("Masa Muscular: xx kg"),
            Text("Masa Grasa: xx kg"),
            Text("Porcentaje de Grasa: xx%"),
            Text("Agua: xx%"),
            Text("Músculo esquelético: xx kg"),
            Text("Nivel de grasa visceral: xx"),
            // Water, IMC, Proteins, Minerals missing
          ],
        ),
        actions: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      );
    }

    return Skeletonizer(
      // ignore: unnecessary_null_comparison
      enabled: _MeasurementsDialog == null,
      child: alertDialog, // Use the defined alertDialog
    );
  }
}
