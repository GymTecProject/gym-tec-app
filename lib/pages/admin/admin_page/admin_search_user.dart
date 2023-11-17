import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/pages/trainer/routine/create_routine.dart';
import 'package:gym_tec/pages/trainer/trainer_page/expantion_tile_content.dart';
import 'package:gym_tec/services/dependency_manager.dart';

import '../../../components/search_users/dialog/admin_dialog.dart';
import '../../../components/search_users/dialog/measurements_dialog.dart';

class AdminSearchUser extends StatefulWidget {
  const AdminSearchUser({super.key});

  @override
  State<AdminSearchUser> createState() => _AdminSearchUserState();
}

class _AdminSearchUserState extends State<AdminSearchUser> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  late Stream<List<UserPublicData>> _usersStream;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _usersStream = dbService.getAllUsersStream();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<UserPublicData> _filterUsers(List<UserPublicData> users, String query) {
    return users
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _navigateToCreateRoutine(String clientId) async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateRoutinePage(
            clientId: clientId,
          ),
        ));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<UserPublicData>>(
              stream: _usersStream,
              builder: (context, snapshot) {
                List<UserPublicData> users =
                    snapshot.hasData ? snapshot.data! : [];
                List<UserPublicData> filteredUsers =
                    _filterUsers(users, _searchQuery);

                return ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    UserPublicData user = filteredUsers[index];
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: ExpansionTile(
                        key: ValueKey(user.id),
                        title: Text(user.name),
                        subtitle: Text(user.expirationDate.toDate().toString()),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                ExpansionTileContent(id: user.id),
                              ],
                            ),
                          ),
                          ContentPadding(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton.filledTonal(
                                  icon: const Icon(Icons.straighten),
                                  tooltip: 'Ver medidas',
                                  onPressed: () async {
                                    final userMeasurements = await dbService
                                        .getUserMeasurements(user.id);
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (context) => MeasurementsDialog(
                                        name: user.name,
                                        m: userMeasurements?.last,
                                      ),
                                    );
                                  },
                                  // child: const Text('Measurements')
                                ),
                                const ItemSeparator(),
                                IconButton.filledTonal(
                                  icon: const Icon(Icons.fitness_center),
                                  tooltip: 'Crear rutina',
                                  onPressed: () =>
                                      _navigateToCreateRoutine(user.id),
                                ),
                                const ItemSeparator(),
                                IconButton.filledTonal(
                                    icon:
                                        const Icon(Icons.admin_panel_settings),
                                    tooltip: 'Admin',
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AdminDialog(user: user);
                                        },
                                      );
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
