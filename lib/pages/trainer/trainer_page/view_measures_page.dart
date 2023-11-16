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

  List<UserMeasurement> _UserMeasurement = [];

  @override
  void initState() {
    super.initState();
    _fetchMeasuresData();
  }

  void _fetchMeasuresData() async {
    if (UserMeasurement == null) {
      print("USERMEASUREMENT IS NULL");
      _UserMeasurement = [];
      return;
    } else {
      print("UserMeasurements len: ${widget.m?.length}");
      print("Last User's age: ${widget.m?.last.age}");
    }
    setState(() {
      _UserMeasurement = widget.m!;
    });
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
