import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/pages/trainer/routine/create_routine.dart';
import 'package:gym_tec/pages/trainer/trainer_page/expantion_tile_content.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'dialog/measurements_dialog.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  bool isAdmin = false;
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

  void _getCurrentRole() async {
    final user = authService.currentUser;
    if (user == null) return;
    final userPrivateData = await dbService.getUserPrivateData(user.uid);
    if (userPrivateData == null) return;

    setState(() {
      (userPrivateData.accountType == AccountType.administrator)
          ? isAdmin = true
          : isAdmin = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllUsers();
    _getCurrentRole();
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

  void _navigateToCreateRoutine() async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateRoutinePage(),
        ));
    if (!mounted) return;
    if (state == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rutina creada exitosamente /falta integrar/'),
          duration: Duration(seconds: 3),
        ),
      );
    }
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
                                      icon: const Icon(Icons.straighten),
                                      tooltip: 'Ver medidas',
                                      onPressed: () {
                                        openDialog(_foundUsers[index].id,
                                            _foundUsers[index].name, dbService);
                                      },
                                      // child: const Text('Measurements')
                                    ),
                                    const ItemSeparator(),
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.fitness_center),
                                      tooltip: 'Crear rutina',
                                      onPressed: _navigateToCreateRoutine,
                                    ),
                                    if (isAdmin) ...{
                                      const ItemSeparator(),
                                      IconButton.filledTonal(
                                        icon: const Icon(
                                            Icons.admin_panel_settings),
                                        tooltip: 'Admin',
                                        onPressed: () {
                                          openAdminDialog(_foundUsers[index]);
                                        },
                                      ),
                                    }
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


//TO DO: Agua corporal total, Masa Grasa Corporal, Masa de Musculo Esqueletico, Porcentaje de grasa corporal, Nivel de Grasa Viceral
  Future openAdminDialog(UserPublicData s) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Client: ${s.name}"),
          content: const Column(mainAxisSize: MainAxisSize.min, children: [
            //Text("User added measurements"),
            SizedBox(height: 10),
            Text("Set Rol"),
            Text("CRUD Client"),
            Text("Add Exp Date"),
          ]),
          actions: const [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      );

  Future openDialog(UserPublicData s) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Client: ${s.name}"),
          content: const Column(mainAxisSize: MainAxisSize.min, children: [
            //Text("User added measurements"),
            SizedBox(height: 10),
            Text("Height: "),
            Text("Weight: "),
            Text("Water: "),
            Text("Protein: "),
            Text("Minerals: "),
            Text("Fat: "),
            Text("Skeletal Muscle Mass: "),
            Text("IMC: "),
            Text("Fat Percentage: "),
          ]),
          actions: const [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      );
}
