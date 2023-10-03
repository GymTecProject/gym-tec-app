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
    UserProtectedData? userProtectedData =
        await dbService.getUserProtectedData(widget.id);
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
      child: _userProtectedData != null
          ? Column(
              children: [
                ListTile(
                  title: Text('Correo: ${_userProtectedData!.email}'),
                ),
                ListTile(
                  title: Text('Telefono: ${_userProtectedData!.phoneNumber}'),
                ),
                ListTile(
                  title: Text('Objetivo: ${_userProtectedData!.objective}'),
                )
              ],
            )
          : const Column(
              children: [
                ListTile(
                  title: Text('Correo: example@gmail.com'),
                ),
                ListTile(
                  title: Text('Telefono: xxxxxxxx'),
                ),
                ListTile(
                  title: Text('Fecha de expiración: xx/xx/xxxx'),
                )
              ],
            ),
    );
  }
}
