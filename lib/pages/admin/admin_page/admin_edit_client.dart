import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:intl/intl.dart';

class AdminEditClient extends StatefulWidget {
  final UserPublicData userPublicData;
  final UserPrivateData userPrivateData;

  const AdminEditClient({
    super.key,
    required this.userPublicData,
    required this.userPrivateData,
  });

  @override
  State<AdminEditClient> createState() => _AdminEditClientState();
}

class _AdminEditClientState extends State<AdminEditClient> {
  DatabaseInterface dbService = DependencyManager.databaseService;

  Set<dynamic>? _selectedAccountType;
  Sex? _selectedSex;
  List<ButtonSegment<dynamic>> accountRols = [
    const ButtonSegment(value: AccountType.client, label: Text("Cliente")),
    const ButtonSegment(value: AccountType.trainer, label: Text("Entrenador")),
    const ButtonSegment(value: AccountType.administrator, label: Text("Admin")),
  ];

  UserPublicData? _userTouchablePublicData;
  UserProtectedData? _userTouchableProtectedData;
  UserPrivateData? _userTouchablePrivateData;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _fetchAllUserData() async {
    String uid = widget.userPublicData.id;
    try {
      UserPublicData? userPublicDataBuffer =
          await dbService.getUserPublicData(uid);
      UserProtectedData? userProtectedDataBuffer =
          await dbService.getUserProtectedData(uid);
      UserPrivateData? userPrivateDataBuffer =
          await dbService.getUserPrivateData(uid);
      setState(() {
        _userTouchablePublicData = userPublicDataBuffer;
        _userTouchableProtectedData = userProtectedDataBuffer;
        _userTouchablePrivateData = userPrivateDataBuffer;

        _selectedAccountType = {_userTouchablePrivateData!.accountType};
        _selectedSex = _userTouchablePublicData!.sex;

        _expirationDateController.text = DateFormat('dd-MM-yyyy')
            .format(_userTouchablePublicData!.expirationDate.toDate());
        _objectiveController.text = _userTouchableProtectedData!.objective;
        _nameController.text = _userTouchablePublicData!.name;
        _emailController.text = _userTouchableProtectedData!.email;
        _phoneController.text = _userTouchableProtectedData!.phoneNumber;

      });
    } catch (e) {
      //auth error
      if (e == 'permission-denied') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No tiene permisos para acceder a esta información'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      //user not found
      if (e == 'not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El usuario no existe'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      //unknown error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error desconocido'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void setSexSelection(Sex value) {
    setState(() {
      _selectedSex = value;
    });
  }

  void _openWarning() async {
    if (!_formKey.currentState!.validate()) return;
    final result = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Cuidado"),
              content: const Text(
                  "¿Está seguro de que desea editar este cliente?\nEsto podría cambiar el acceso a información sensible de la aplicación para este usuario"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancelar")),
                FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text("Aceptar"))
              ],
            ));
    if (result == true) {
      UserPublicData newUserPublicData = UserPublicData(
          name: _nameController.text,
          sex: _selectedSex!,
          expirationDate: Timestamp.fromDate(DateFormat('dd-MM-yyyy').parse(_expirationDateController.text)));
      UserProtectedData newUserProtectedData = UserProtectedData(
          id: _userTouchableProtectedData!.id,
          email: _emailController.text,
          phoneNumber: _phoneController.text,
          objective: _objectiveController.text,
          medicalConditions: _userTouchableProtectedData!.medicalConditions);
      UserPrivateData newUserPrivateData =
          UserPrivateData(accountType: _selectedAccountType!.first);

      await dbService.createUserPublicData(
          widget.userPublicData.id, newUserPublicData.toJson());
      await dbService.createUserProtectedData(
          widget.userPublicData.id, newUserProtectedData.toJson());
      await dbService.createUserPrivateData(
          widget.userPublicData.id, newUserPrivateData.toJson());

      if(!mounted)  return;
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAllUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar cliente'),
      ),
      body: _userTouchablePrivateData == null ||
              _userTouchableProtectedData == null ||
              _userTouchablePublicData == null
          ? const Center(child: CircularProgressIndicator())
          : ContentPadding(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        color: Theme.of(context).colorScheme.surface,
                        child: ContentPadding(
                          child: Column(
                            children: [
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Cuenta")),
                              const ContextSeparator(),
                              TextFormField(
                                controller: _expirationDateController,
                                decoration: InputDecoration(
                                  labelText: "Fecha de expiración",
                                  hintText: "Fecha de expiración",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 365)),
                                        confirmText: "Aceptar",
                                      );
                                      if (newDate == null) return;
                                      setState(() {
                                        _expirationDateController.text =
                                            DateFormat('dd-MM-yyyy')
                                                .format(newDate);
                                      });
                                    },
                                    icon: const Icon(Icons.calendar_today),
                                  ),
                                ),
                                readOnly: true,
                              ),
                              const ContextSeparator(),
                              Row(
                                children: [
                                  Expanded(
                                    child: SegmentedButton(
                                        segments: accountRols,
                                        selected: _selectedAccountType!,
                                        onSelectionChanged: (value) {
                                          setState(() {
                                            _selectedAccountType = value;
                                          });
                                        },
                                        showSelectedIcon: false,
                                        multiSelectionEnabled: false),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const ItemSeparator(),
                      Card(
                        color: Theme.of(context).colorScheme.surface,
                        child: ContentPadding(
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Información personal"),
                              ),
                              const ContextSeparator(),
                              TextFormField(
                                controller: _objectiveController,
                                decoration: const InputDecoration(
                                  labelText: "Objetivo",
                                  hintText: "Objetivo",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese un objetivo';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: "Nombre",
                                  hintText: "Nombre",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese un nombre';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _emailController,

                                decoration: const InputDecoration(
                                  labelText: "Correo electrónico",
                                  hintText: "Correo electrónico",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese un correo electrónico';
                                  }
                                  if (!value.contains('@') &&
                                      !value.contains('.')) {
                                    return 'Por favor ingrese un correo electrónico válido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _phoneController,
                                decoration: const InputDecoration(
                                  labelText: "Teléfono",
                                  hintText: "Teléfono",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese un teléfono';
                                  }
                                  if (value.length < 8) {
                                    return 'Por favor ingrese un teléfono válido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    clipBehavior: Clip.hardEdge,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    child: InkWell(
                                        onTap: () => setSexSelection(Sex.male),
                                        child: SizedBox(
                                          width: 75,
                                          height: 75,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text('Hombre'),
                                              Icon(Icons.male,
                                                  color:
                                                      _selectedSex == Sex.male
                                                          ? Colors.blue
                                                          : null),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Card(
                                    clipBehavior: Clip.hardEdge,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    child: InkWell(
                                      onTap: () => setSexSelection(Sex.female),
                                      child: SizedBox(
                                        width: 75,
                                        height: 75,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text('Mujer'),
                                            Icon(Icons.female,
                                                color:
                                                    _selectedSex == Sex.female
                                                        ? Colors.red
                                                        : null),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                      clipBehavior: Clip.hardEdge,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                      child: InkWell(
                                          onTap: () =>
                                              setSexSelection(Sex.other),
                                          child: SizedBox(
                                              width: 75,
                                              height: 75,
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Text('Otro'),
                                                    Icon(
                                                      Icons
                                                          .do_not_disturb_on_outlined,
                                                      color: _selectedSex ==
                                                              Sex.other
                                                          ? Colors.amber
                                                          : null,
                                                    )
                                                  ])))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const ContextSeparator(),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openWarning,
        shape: const CircleBorder(),
        child: const Icon(Icons.save),
      ),
    );
  }
}
