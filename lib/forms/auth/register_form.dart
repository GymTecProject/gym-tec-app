import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/form_interface.dart';
import 'package:gym_tec/models/users/user_data_public.dart';

import '../../models/users/user_register_form.dart';

enum SexOption {
  male('Masculino', Sex.male),
  female('Femenino', Sex.female),
  none('Ninguno', Sex.none);

  const SexOption(this.label, this.value);
  final String label;
  final Sex value;
}

class RegisterForm extends StatefulWidget implements FormInterface {
  const RegisterForm({super.key});

  @override
  Function get onSubmit => throw UnimplementedError();

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

/*TODO: 
- add validations
- add state to the sex selector
- init _userRegisterForm
- set _userRegisterForm values
- validate _userRegisterForm
- return a valid UserRegisterForm
*/

class _RegisterFormState extends State<RegisterForm> {
  late GlobalKey<FormState> _formKey;
  late UserRegisterForm _userRegisterForm;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  void setBirthDate() async {

    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: dateLowLimit(),
        lastDate: dateTopLimit());
    if (date != null) {
      //format to mm/dd/yyyy
      String formattedDate = "${date.month}/${date.day}/${date.year}";
      _birthDateController.text = formattedDate;

      //make a timestamp
      Timestamp timestamp = Timestamp.fromDate(date);
    }
  }

  DateTime dateLowLimit() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year - 100, now.month, now.day);
    return date;
  }

  DateTime dateTopLimit() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year + 100, now.month, now.day);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<SexOption>> sexOptions = [];
    for (SexOption option in SexOption.values) {
      sexOptions.add(DropdownMenuEntry(
        value: option,
        label: option.label,
      ));
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: ContentPadding(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nombre Completo',
                  labelText: 'Nombre Completo',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const ItemSeparator(),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Telefono',
                  labelText: 'Telefono',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const ItemSeparator(),

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Correo',
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const ItemSeparator(),

              //Fecha de nacimiento
              TextFormField(
                controller: _birthDateController,
                validator: (value) {
                  // validate this format mm/dd/yyyy
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su fecha de nacimiento';
                  }
                  if (!value.contains('/')) {
                    return 'Por favor ingrese una fecha válida';
                  }
                  List<String> date = value.split('/');
                  if (date.length != 3) {
                    return 'Por favor ingrese una fecha válida';
                  }
                  if (date[0].length > 2 ||
                      date[1].length > 2 ||
                      date[2].length != 4) {
                    return 'Por favor ingrese una fecha válida';
                  }
                  if (int.parse(date[0]) > 12 || int.parse(date[0]) < 1) {
                    return 'Por favor ingrese una fecha válida';
                  }

                  if (int.parse(date[1]) > 31 || int.parse(date[1]) < 1) {
                    return 'Por favor ingrese una fecha válida';
                  }
                  if (DateTime.parse(date[2]).compareTo(dateLowLimit()) < 0 ||
                      DateTime.parse(date[2]).compareTo(dateTopLimit()) > 0) {
                    return 'Por favor ingrese una fecha válida';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('Fecha de nacimiento'),
                  hintText: 'mm/dd/yyyy',
                  prefixIcon: const Icon(Icons.cake),
                  suffixIcon: IconButton(
                      onPressed: setBirthDate,
                      icon: const Icon(Icons.calendar_today)),
                ),
              ),
              const ItemSeparator(),

              Card(
                child: ContentPadding(
                  child: Column(
                    children: [
                      const Text('Sexo'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Card(
                            clipBehavior: Clip.hardEdge,
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: InkWell(
                                onTap: () {},
                                child: const SizedBox(
                                  width: 75,
                                  height: 75,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Hombre'),
                                      Icon(Icons.male),
                                    ],
                                  ),
                                )),
                          ),
                          Card(
                            clipBehavior: Clip.hardEdge,
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: InkWell(
                              onTap: () {},
                              child: const SizedBox(
                                width: 75,
                                height: 75,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Mujer'),
                                    Icon(Icons.female),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const ItemSeparator(),

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const ItemSeparator(),

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Confirmar contraseña',
                  labelText: 'Confirmar contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const ContextSeparator(),
              ActionBtn(
                title: "Registrarse",
                onPressed: () {},
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
