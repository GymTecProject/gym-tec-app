import 'package:flutter/material.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/services/dependency_manager.dart';

import '../../../components/search_users/custom_list_tile.dart';

class ExpansionTileContent extends StatefulWidget {
  final String id;
  final String accType;

  const ExpansionTileContent(
      {super.key, required this.id, required this.accType});

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
        CustomListTile(
          title: 'Tipo de Usuario',
          content: widget.accType,
          icon: Icons.person,
        ),
        StreamBuilder<UserProtectedData>(
            stream: dbService.getUserProtectedDataStream(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userProtectedData = snapshot.data!;
                return Column(
                  children: [
                    CustomListTile(
                      title: 'Correo',
                      content: userProtectedData.email,
                      icon: Icons.email,
                    ),
                    CustomListTile(
                      title: 'Teléfono',
                      content: userProtectedData.phoneNumber,
                      icon: Icons.phone,
                    ),
                    CustomListTile(
                      title: 'Objetivo',
                      content: userProtectedData.objective,
                      icon: Icons.flag,
                    ),
                    ...userProtectedData.medicalConditions
                        .map((condition) => CustomListTile(
                              title: 'Condición Médica',
                              content: condition,
                              icon: Icons.healing,
                            ))
                        .toList(),
                  ],
                );
              }
              return const Center(
                child: SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: CircularProgressIndicator(),
                ),
              );
            })
      ],
    );
  }
}
