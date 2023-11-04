import 'package:flutter/material.dart';
import '../../../../models/users/user_data_public.dart';

class AdminDialog extends StatefulWidget {
  final UserPublicData user;

  const AdminDialog({Key? key, required this.user}) : super(key: key);

  @override
  State<AdminDialog> createState() => _AdminDialogState();
}

class _AdminDialogState extends State<AdminDialog> {
  String selectedRole = 'Cliente';
  String selectedDuration = '(No aumentar)';

  TextStyle myTextStyle = const TextStyle(
    fontSize: 15,
    //fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    //fontStyle: FontStyle.italic,
  );

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.user.name),
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
              createRoleButton('Entrenador', selectedRole == 'Entrenador', () {
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
  }
}
