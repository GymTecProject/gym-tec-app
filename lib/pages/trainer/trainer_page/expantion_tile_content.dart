import 'package:flutter/material.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExpansionTileContent extends StatefulWidget {
  final String id;

  const ExpansionTileContent({super.key, required this.id});

  @override
  State<ExpansionTileContent> createState() => _ExpansionTileContentState();
}

class _ExpansionTileContentState extends State<ExpansionTileContent> {

  final DatabaseInterface dbService = DependencyManager.databaseService;
  UserProtectedData? _userProtectedData;

  void _getUserProtectedData() async {
    UserProtectedData? userProtectedData = await dbService.getUserProtectedData(widget.id);
    if (userProtectedData != null) {
      setState(() {
        _userProtectedData = userProtectedData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserProtectedData();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: _userProtectedData == null,
      child: Column(
        children: [
          Text(_userProtectedData?.email??''),
          Text(_userProtectedData?.phoneNumber??''),
          Text(_userProtectedData?.objective??''),
        ],
      ), // !=el valor nunca va a ser nullo | ?=el valor puede ser nullo
    );
  }
}

