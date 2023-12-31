import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/pages/trainer/routine/create_routine.dart';
import 'package:gym_tec/pages/trainer/trainer_page/expantion_tile_content.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:intl/intl.dart';

import '../../../models/users/user_data_private.dart';
import '../../../models/users/user_data_public.dart';
import '../../../models/users/user_data_public_private.dart';
import '../../../models/measures/measurements.dart';
import '../../trainer/measures/create_measures.dart';
import '../../trainer/trainer_page/view_measures_page.dart';
import 'admin_edit_client.dart';

class AdminSearchUser extends StatefulWidget {
  const AdminSearchUser({super.key});

  @override
  State<AdminSearchUser> createState() => _AdminSearchUserState();
}

class _AdminSearchUserState extends State<AdminSearchUser> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  late Stream<List<UserPublicPrivateData>> _usersStream;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int? _value;
  final List<String> _accTypes = ['Administrador', 'Entrenador', 'Cliente'];

  @override
  void initState() {
    super.initState();
    _usersStream = dbService.getAllUsersPublicPrivateDataStream();
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

  AccountType _mapStringToAccountType(String accountTypeString) {
    switch (accountTypeString) {
      case 'Administrador':
        return AccountType.administrator;
      case 'Entrenador':
        return AccountType.trainer;
      case 'Cliente':
        return AccountType.client;
      default:
        throw Exception('Invalid account type string');
    }
  }

  List<UserPublicPrivateData> _filterUsers(
      List<UserPublicPrivateData> users, String query) {
    return users.where((user) {
      bool nameMatches =
          user.publicData.name.toLowerCase().contains(query.toLowerCase());

      bool accountTypeMatches = true;
      if (_value != null) {
        var selectedAccountType = _mapStringToAccountType(_accTypes[_value!]);
        accountTypeMatches =
            user.privateData.accountType == selectedAccountType;
      }

      return nameMatches && accountTypeMatches;
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

  void _navigateToRegisterMeasures(String clientId) async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateMeasuresPage(
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
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewMeasures(
            m: m,
          ),
        ));
  }

  void _navigateToAdminClient(UserPublicData user, UserPrivateData userType) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminEditClient(
            userPublicData: user,
            userPrivateData: userType,
          ),
        ));
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
                  labelText: 'Buscar',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            ContentPadding(
              padding: 10,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < _accTypes.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ChoiceChip(
                            label: Text(_accTypes[i]),
                            selected: _value == i,
                            onSelected: (bool selected) {
                              setState(() {
                                _value = selected ? i : null;
                              });
                            },
                          ),
                        ),
                    ],
                  )),
            ),
            Expanded(
              child: StreamBuilder<List<UserPublicPrivateData>?>(
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
                    return const Text('Error or no data');
                  }

                  List<UserPublicPrivateData> users = snapshot.data!;
                  List<UserPublicPrivateData> filteredUsers =
                      _filterUsers(users, _searchQuery);

                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      UserPublicPrivateData user = filteredUsers[index];

                      String sexText = user.publicData.sex == Sex.male
                          ? "Hombre"
                          : user.publicData.sex == Sex.female
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
                            key: ValueKey(user.publicData.id),
                            title: Text(
                              user.publicData.name,
                              style: TextStyle(
                                color: user.publicData.expirationDate
                                        .toDate()
                                        .isBefore(DateTime.now())
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                            subtitle: Text(
                                "$sexText - ${DateFormat('dd/MM/yyyy').format(user.publicData.expirationDate.toDate())}"),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    ExpansionTileContent(
                                        id: user.publicData.id,
                                        accType: user.privateData
                                            .getAccountTypeString()),
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
                                            await dbService.getUserMeasurements(
                                                user.publicData.id);
                                        _navigateToSeeMeasures(
                                            userMeasurements);
                                      },
                                    ),
                                    const ItemSeparator(),
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.straighten),
                                      tooltip: 'Registrar medidas',
                                      onPressed: () =>
                                          _navigateToRegisterMeasures(
                                              user.publicData.id),
                                    ),
                                    const ItemSeparator(),
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.fitness_center),
                                      tooltip: 'Crear rutina',
                                      onPressed: () => _navigateToCreateRoutine(
                                          user.publicData.id),
                                    ),
                                    const ItemSeparator(),
                                    IconButton.filledTonal(
                                      icon: const Icon(
                                          Icons.admin_panel_settings),
                                      tooltip: 'Admin',
                                      onPressed: () {
                                        _navigateToAdminClient(
                                            user.publicData, user.privateData);
                                        // final result = await showDialog(
                                        //   context: context,
                                        //   builder: (context) {
                                        //     return AdminDialog(
                                        //         user: user.publicData,
                                        //         initialRole: user.privateData
                                        //             .getAccountTypeString());
                                        //   },
                                        // );
                                        // if (result ==
                                        //     'Rol actualizado con éxito.') {
                                        //   _usersStream = dbService
                                        //       .getAllUsersPublicPrivateDataStream();
                                        //   setState(() {});
                                        // }
                                      },
                                    ),
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
