import 'package:flutter/material.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import '../../../interfaces/database_interface.dart';
import '../../../models/users/user_data_public.dart';
import '../../../services/dependency_manager.dart';
import 'admin_public_data.dart';
import 'admin_protected_data.dart';

class AdminDialog extends StatefulWidget {
  final UserPublicData user;
  final String initialRole;

  const AdminDialog({Key? key, required this.user, required this.initialRole})
      : super(key: key);

  @override
  State<AdminDialog> createState() => _AdminDialogState();
}

class _AdminDialogState extends State<AdminDialog> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  String selectedRole = 'Cliente';

  @override
  void initState() {
    super.initState();
    selectedRole = widget.initialRole;
  }

  void savePrivateData(String str) async {
    dynamic type;
    switch (str) {
      case "Entrenador":
        type = AccountType.trainer;
        break;
      case "Admin":
        type = AccountType.administrator;
        break;
      default:
        type = AccountType.client;
        break;
    }

    final privateData = UserPrivateData(accountType: type);
    try {
      await dbService.createUserPrivateData(
          widget.user.id, privateData.toJson());
      if (!mounted) return;
      Navigator.pop(context, 'Rol actualizado con éxito.');
    } catch (e) {
      Navigator.pop(context, 'Error al cambiar el rol del usuario.');
    }
  }

  Widget createRoleButton(String role, bool isSelected, Function() onPressed) {
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
                topLeft:
                    role == 'Admin' ? const Radius.circular(8.0) : Radius.zero,
                bottomLeft:
                    role == 'Admin' ? const Radius.circular(8.0) : Radius.zero,
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
              ]),
          child: Center(
            child: Text(role),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        widget.user.name,
        style: Theme.of(context).textTheme.headlineLarge,
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Text(
                "Establecer Rol",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  createRoleButton('Admin', selectedRole == 'Admin', () {
                    setState(() {
                      selectedRole = 'Admin';
                    });
                  }),
                  createRoleButton('Entrenador', selectedRole == 'Entrenador',
                      () {
                    setState(() {
                      selectedRole = 'Entrenador';
                    });
                  }),
                  createRoleButton('Cliente', selectedRole == 'Cliente', () {
                    setState(() {
                      selectedRole = 'Cliente';
                    });
                  }),
                ],
              ),
              TextButton(
                onPressed: () {
                  savePrivateData(selectedRole);
                },
                child: const Text("Aplicar rol"),
              ),
            ],
          ),
          const Divider(),
          Column(
            children: [
              Text(
                "Actualizar datos",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputChip(
                      label: const Text("Datos Públicos"),
                      showCheckmark: false,
                      selected: false,
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                AdminPublicData(user: widget.user)));
                      },
                    ),
                  ),
                  Expanded(
                    child: InputChip(
                      label: const Text("Datos Protegidos"),
                      showCheckmark: false,
                      selected: false,
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                AdminProtectedData(uid: widget.user.id)));
                      },
                    ),
                  ),
                ],
              ),
            ],
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
  }
}
