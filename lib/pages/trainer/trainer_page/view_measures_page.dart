import 'package:flutter/material.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/services/dependency_manager.dart';


class ViewMeasures extends StatefulWidget {
  final String clientId;

  const ViewMeasures({super.key, required this.clientId});

  @override
  _ViewMeasuresState createState() => _ViewMeasuresState();
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

    final UserMeasurement = await dbService.getUserMeasurements(widget.clientId);
    print("USER IS VALID");
    if (UserMeasurement == null) {
      print("USErMEASUREMENT IS NULL");
      _UserMeasurement = [];
      return;
    }else{
      print(_UserMeasurement.last);
    }
    setState(() {
      _UserMeasurement = UserMeasurement;
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
