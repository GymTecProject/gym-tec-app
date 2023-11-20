import 'package:flutter/material.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/services/dependency_manager.dart';

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
        ListTile(
          title: Text('Tipo de Usuario: ${widget.accType}'),
        ),
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
                    ),
                    ...List.generate(
                      userProtectedData.medicalConditions.length,
                      (index) => ListTile(
                        title: Text(
                            'Condición Médica ${index + 1}: ${userProtectedData.medicalConditions[index]}'),
                      ),
                    ),
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
