import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/form_interface.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/utils/string_utils.dart';

import '../../models/users/user_register_form.dart';

enum SexOption {
  male('Masculino', Sex.male),
  female('Femenino', Sex.female),
  none('Ninguno', Sex.other);

  const SexOption(this.label, this.value);
  final String label;
  final Sex value;
}

class RegisterForm extends StatefulWidget implements FormInterface {
  const RegisterForm({super.key, required this.onSubmit});

  @override
  final void Function(UserRegisterForm) onSubmit;

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
  late Sex _selectedSex;
  late bool _isObscure;

  final TextEditingController _nameController = TextEditingController();
  final RegExp _nameValidCharacters = RegExp(r'^[a-zA-Z ]+$');

  final TextEditingController _phoneController = TextEditingController();
  final RegExp _phoneValidCharacters = RegExp(r'^[0-9]+$');

  final TextEditingController _emailController = TextEditingController();
  final RegExp _emailValidCharacters =
      RegExp(r'^[\w\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _isObscure = true;
    _selectedSex = Sex.other;
    _formKey = GlobalKey<FormState>();
    _userRegisterForm = UserRegisterForm(
        name: "",
        phoneNumber: "",
        email: "",
        birthdate: Timestamp.now(),
        sex: Sex.other,
        password: "");
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
    }
  }

  void setSexSelection(Sex value) {
    setState(() {
      _selectedSex = value;
    });
  }

  void obscurePassword() {
    setState(() {
      _isObscure = !_isObscure;
    });
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

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      List<String> date = _birthDateController.text.split('/');
      String validBirthDate =
          '${date[2]}-${date[0].length < 2 ? '0${date[0]}' : date[0]}-${date[1].length < 2 ? '0${date[1]}' : date[1]}';

      _userRegisterForm.name =
          _nameController.text.trim().toLowerCase().toTitleCase();
      _userRegisterForm.phoneNumber = _phoneController.text.trim();
      _userRegisterForm.email = _emailController.text.trim();
      _userRegisterForm.birthdate =
          Timestamp.fromDate(DateTime.parse(validBirthDate));
      _userRegisterForm.sex = _selectedSex;
      _userRegisterForm.password = _passwordController.text;
      widget.onSubmit(_userRegisterForm);
    }
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
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  if (!_nameValidCharacters.hasMatch(value)) {
                    return 'Por favor ingrese un nombre válido';
                  }
                  if (!value.contains(' ')) {
                    return 'Ingrese su nombre completo separado por espacios';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Nombre Completo',
                  labelText: 'Nombre Completo',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const ItemSeparator(),
              TextFormField(
                controller: _phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su número de teléfono';
                  }
                  if (!_phoneValidCharacters.hasMatch(value)) {
                    return 'Por favor ingrese un número de teléfono válido';
                  }
                  if (value.length < 8) {
                    return 'Por favor ingrese un número de teléfono válido';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Telefono',
                  labelText: 'Telefono',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const ItemSeparator(),

              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  if (!_emailValidCharacters.hasMatch(value)) {
                    return 'Por favor ingrese un correo electrónico válido';
                  }
                  return null;
                },
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
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su fecha de nacimiento';
                  }
                  if (!value.contains('/')) {
                    return 'Por favor ingrese una fecha válida';
                  }
                  List<String> date = value.split('/');
                  String formattedDate =
                      '${date[2]}-${date[0].length < 2 ? '0${date[0]}' : date[0]}-${date[1].length < 2 ? '0${date[1]}' : date[1]}';

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
                  if (DateTime.parse(formattedDate).compareTo(dateLowLimit()) <
                          0 ||
                      DateTime.parse(formattedDate).compareTo(dateTopLimit()) >
                          0) {
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
                      const ItemSeparator(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Card(
                            clipBehavior: Clip.hardEdge,
                            color: Theme.of(context).colorScheme.surfaceVariant,
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
                                          color: _selectedSex == Sex.male
                                              ? Colors.blue
                                              : null),
                                    ],
                                  ),
                                )),
                          ),
                          Card(
                            clipBehavior: Clip.hardEdge,
                            color: Theme.of(context).colorScheme.surfaceVariant,
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
                                        color: _selectedSex == Sex.female
                                            ? Colors.red
                                            : null),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                              clipBehavior: Clip.hardEdge,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: InkWell(
                                  onTap: () => setSexSelection(Sex.other),
                                  child: SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text('Otro'),
                                            Icon(
                                              Icons.do_not_disturb_on_outlined,
                                              color: _selectedSex == Sex.other
                                                  ? Colors.amber
                                                  : null,
                                            )
                                          ]))))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const ItemSeparator(),

              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  if (value.length < 8) {
                    return 'La contraseña debe tener al menos 8 caracteres';
                  }
                  return null;
                },
                obscureText: _isObscure,
                decoration: InputDecoration(
                    hintText: 'Contraseña',
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: obscurePassword,
                        icon: _isObscure
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off))),
              ),
              const ItemSeparator(),

              TextFormField(
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
                obscureText: _isObscure,
                decoration: InputDecoration(
                    hintText: 'Confirmar contraseña',
                    labelText: 'Confirmar contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: obscurePassword,
                        icon: _isObscure
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off))),
              ),
              const ContextSeparator(),
              ActionBtn(
                title: "Registrarse",
                onPressed: submitForm,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
