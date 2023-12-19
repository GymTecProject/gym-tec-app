import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/measures/measurements.dart';
import 'package:gym_tec/pages/trainer/measures/create_measures.dart';
import 'package:gym_tec/pages/trainer/routine/create_routine.dart';
import 'package:gym_tec/pages/trainer/trainer_page/expantion_tile_content.dart';
import 'package:gym_tec/pages/trainer/trainer_page/view_measures_page.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:intl/intl.dart';

import '../../../models/users/user_data_public.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  late Stream<List<UserPublicData>> _usersStream;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _usersStream = dbService.getActiveUsersPublicDataStream();
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
    return users.where((user) {
      bool nameMatches = user.name.toLowerCase().contains(query.toLowerCase());

      return nameMatches;
    }).toList();
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
    if (state == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateToSeeMeasures(List<UserMeasurement>? m) async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewMeasures(
            m: m,
          ),
        ));
    if (!mounted) return;
    if (state == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateToRegisterMeasures(String clientId) async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateMeasuresPage(
            clientId: clientId,
          ),
        ));
    if (!mounted) return;
    if (state != null) return;
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
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
            const ContextSeparator(),
            Expanded(
              child: StreamBuilder<List<UserPublicData>>(
                stream: _usersStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    print(snapshot.error);
                    print(snapshot.data);
                    return const Text('Error or no data');
                  }

                  List<UserPublicData> users = snapshot.data!;
                  List<UserPublicData> filteredUsers =
                      _filterUsers(users, _searchQuery);

                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      UserPublicData user = filteredUsers[index];

                      String sexText = user.sex == Sex.male
                          ? "Hombre"
                          : user.sex == Sex.female
                              ? "Mujer"
                              : "Otro";

                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            key: ValueKey(user.id),
                            title: Text(user.name),
                            subtitle: Text(
                                "$sexText - ${DateFormat('dd/MM/yyyy').format(user.expirationDate.toDate())}"),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    ExpansionTileContent(
                                      id: user.id,
                                    )
                                  ],
                                ),
                              ),
                              ContentPadding(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.remove_red_eye),
                                      tooltip: 'Visualizar medidas',
                                      onPressed: () async {
                                        final userMeasurements = await dbService
                                            .getUserMeasurements(user.id);
                                        _navigateToSeeMeasures(
                                            userMeasurements);
                                      },
                                    ),
                                    const ItemSeparator(),
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.straighten),
                                      tooltip: 'Registrar medidas',
                                      onPressed: () =>
                                          _navigateToRegisterMeasures(user.id),
                                    ),
                                    const ItemSeparator(),
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.fitness_center),
                                      tooltip: 'Crear rutina',
                                      onPressed: () =>
                                          _navigateToCreateRoutine(user.id),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
