import 'package:flutter/material.dart';


class ViewMeasures extends StatefulWidget {
  final String clientId;

  const ViewMeasures({super.key, required this.clientId});

  @override
  _ViewMeasuresState createState() => _ViewMeasuresState();
}

class _ViewMeasuresState extends State<ViewMeasures> {
  // Aquí puedes declarar variables y métodos que necesites

  @override
  void initState() {
    super.initState();
    // Inicialización si es necesaria
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Measures'),
      ),
      body: Center(
        child: Text('Contenido de ViewMeasures'),
      ),
    );
  }
}
