import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/pages/trainer/measures/create_measures.dart';
import 'package:gym_tec/pages/trainer/routine/create_routine.dart';
import 'package:gym_tec/pages/trainer/trainer_page/expantion_tile_content.dart';
import 'package:gym_tec/pages/trainer/trainer_page/view_measures_page.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  late List<UserPublicData> _foundUsers = [];
  late List<UserPublicData> _allUsers = [];

  void _getAllUsers() async {
    List<UserPublicData>? users = await dbService.getActiveUsers();
    if (users != null) {
      setState(() {
        _allUsers = users;
        _foundUsers = _allUsers;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllUsers();
  }

  void _runFilter(String entered) {
    List<UserPublicData> results = [];
    if (entered.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where(
              (user) => user.name.toLowerCase().contains(entered.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
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

  void _navigateToSeeMeasures(List<UserMeasurement>? m) async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewMeasures(
            m: m,
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

  void _navigateToRegisterMeasures(String clientId) async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateMeasuresPage(
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
    return Skeletonizer(
      enabled: _allUsers.isEmpty,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Clientes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SearchAnchor(
                builder: (context, controller) => SearchBar(
                  hintText: 'Buscar Clientes',
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onChanged: ((value) => _runFilter(value)),
                  trailing: const <Widget>[Icon(Icons.search)],
                ),
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
              ),
              const ContextSeparator(),
              Expanded(
                child: _allUsers.isNotEmpty
                    ? ListView.builder(
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => Card(
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            key: ValueKey(_foundUsers[index].id),
                            title: Text(_foundUsers[index].name),
                            subtitle: Text(_foundUsers[index]
                                .expirationDate
                                .toDate()
                                .toString()),
                            shape: const Border(),
                            // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    ExpansionTileContent(
                                        id: _foundUsers[index].id),
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
                                          final userMeasurements =
                                              await dbService
                                                  .getUserMeasurements(
                                                      _foundUsers[index].id);
                                          _navigateToSeeMeasures(
                                              userMeasurements);
                                        }),
                                    const ItemSeparator(),
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.straighten),
                                      tooltip: 'Registrar medidas',
                                      onPressed: () =>
                                          _navigateToRegisterMeasures(
                                              _foundUsers[index].id),
                                    ),
                                    const ItemSeparator(),
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.fitness_center),
                                      tooltip: 'Crear rutina',
                                      onPressed: () => _navigateToCreateRoutine(
                                          _foundUsers[index].id),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) => const Card(
                            clipBehavior: Clip.antiAlias,
                            child: ExpansionTile(
                              title: Text("Nombre de ejemplo"),
                              subtitle: Text("Fecha de expiracion: xx/xx/xxxx"),
                            )),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
