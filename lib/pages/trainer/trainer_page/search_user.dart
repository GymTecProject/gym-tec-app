import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/pages/trainer/routine/create_routine.dart';
import 'package:gym_tec/pages/trainer/trainer_page/expantion_tile_content.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../models/users/user_measurements.dart';

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
    List<UserPublicData>? users = (isAdmin)
        ? await dbService.getAllUsers()
        : await dbService.getActiveUsers();
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
    _getCurrentRole();
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
                                      onPressed: () async {
                                        openDialog(
                                            _foundUsers[index],
                                            await dbService.getUserMeasurements(
                                                _foundUsers[index].id));
                                      },
                                      // child: const Text('Measurements')
                                    ),
                                    const ItemSeparator(),
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.fitness_center),
                                      tooltip: 'Crear rutina',
                                      onPressed: () => _navigateToCreateRoutine(
                                          _foundUsers[index].id),
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
  Future openAdminDialog(UserPublicData s) {
    String selectedRole = 'Cliente';
    String selectedDuration = '(No aumentar)';

    TextStyle myTextStyle = const TextStyle(
      fontSize: 15,
      //fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      //fontStyle: FontStyle.italic,
    );

    Widget createRoleButton(
        String role, bool isSelected, Function() onPressed) {
      return Expanded(
        child: InkWell(
          onTap: () {
            if (!isSelected) {
              onPressed();
            }
          },
          child: Container(
            height: 30.0,
            decoration: BoxDecoration(
                color: isSelected ? Colors.green : null,
                borderRadius: BorderRadius.only(
                  topLeft: role == 'Admin'
                      ? const Radius.circular(8.0)
                      : Radius.zero,
                  bottomLeft: role == 'Admin'
                      ? const Radius.circular(8.0)
                      : Radius.zero,
                  topRight: role == 'Cliente'
                      ? const Radius.circular(8.0)
                      : Radius.zero,
                  bottomRight: role == 'Cliente'
                      ? const Radius.circular(8.0)
                      : Radius.zero,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ]
                /*
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2), // Outline color
                  width: 1.0, // Outline width
                )*/
                ),
            child: Center(
              child: Text(role),
            ),
          ),
        ),
      );
    }

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(s.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(),
                  Text(
                    "Establecer Rol",
                    style: myTextStyle,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      createRoleButton('Admin', selectedRole == 'Admin', () {
                        setState(() {
                          selectedRole = 'Admin';
                        });
                      }),
                      createRoleButton(
                          'Entrenador', selectedRole == 'Entrenador', () {
                        setState(() {
                          selectedRole = 'Entrenador';
                        });
                      }),
                      createRoleButton('Cliente', selectedRole == 'Cliente',
                          () {
                        setState(() {
                          selectedRole = 'Cliente';
                        });
                      }),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Print the selected duration
                      print(
                          "Selected rol: $selectedRole"); //Aplicar en la base de datos y actualizar el texto donde se muestra
                    },
                    child: const Text("Aplicar rol"),
                  ),
                  const Divider(),
                  Text(
                    "CRUD Client",
                    style: myTextStyle,
                  ),
                  const Divider(),
                  Text(
                    "Fecha de Expiración",
                    style: myTextStyle,
                  ),
                  const Text(
                      "YYYY-MM-DD"), //Mostrar fecha de expiracion de la base de datos
                  Row(
                    children: [
                      const Text("Aumentar tiempo de suscripción: "),
                      DropdownButton<String>(
                        value: selectedDuration,
                        items: ['(No aumentar)', '1 mes', '6 meses', '1 año']
                            .map((String duration) {
                          return DropdownMenuItem<String>(
                            value: duration,
                            child: Text(duration),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedDuration = newValue;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Print the selected duration
                      print(
                          "Selected Duration: $selectedDuration"); //Aplicar en la base de datos y actualizar el texto donde se muestra
                    },
                    child: const Text("Aplicar suscripción"),
                  ),
                ],
              ),
              actions: const [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future openDialog(UserPublicData s, UserMeasurements? userMeasurements) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Client: ${s.name}"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          //Text("User added measurements"),
          const SizedBox(height: 10),
          Text("Age: ${userMeasurements?.age}"),
          Text("Height: ${userMeasurements?.height}"),
          Text("Weight: ${userMeasurements?.weight}"),
          Text("Water: "),
          Text("Protein: "),
          Text("Minerals: "),
          Text("Fat: ${userMeasurements?.fatMass}"),
          Text("Skeletal Muscle Mass: ${userMeasurements?.muscleMass}"),
          Text("IMC: "),
          Text("Fat Percentage: ${userMeasurements?.fatPercentage}"),
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
}
