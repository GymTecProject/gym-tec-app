import 'package:flutter/material.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/services/dependency_manager.dart';

import '../../../models/users/user_data_private.dart';

class ExpansionTileContent extends StatefulWidget {
  final String id;

  const ExpansionTileContent({super.key, required this.id});

  @override
  State<ExpansionTileContent> createState() => _ExpansionTileContentState();
}

class _ExpansionTileContentState extends State<ExpansionTileContent> {
  final DatabaseInterface dbService = DependencyManager.databaseService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<UserPrivateData>(
            stream: dbService.getUserPrivateDataStream(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userPrivateData = snapshot.data!;
                return ListTile(
                  title: Text(
                      'Tipo de Usuario: ${userPrivateData.getAccountTypeString()}'),
                );
              }
              return const CircularProgressIndicator();
            }),
        StreamBuilder<UserProtectedData>(
            stream: dbService.getUserProtectedDataStream(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userProtectedData = snapshot.data!;
                return Column(
                  children: [
                    ListTile(
                      title: Text('Correo: ${userProtectedData.email}'),
                    ),
                    ListTile(
                      title: Text('Telefono: ${userProtectedData.phoneNumber}'),
                    ),
                    ListTile(
                      title: Text('Objetivo: ${userProtectedData.objective}'),
                    )
                  ],
                );
              }
              return const CircularProgressIndicator();
            })
      ],
    );
  }
}
