import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/models/users/user_login_form.dart';

import '../../components/ui/buttons/action_btn.dart';
import '../../components/ui/separators/context_separator.dart';
import '../../components/ui/separators/item_separator.dart';
import '../../interfaces/form_interface.dart';

class LoginForm extends StatefulWidget implements FormInterface{

  const LoginForm({super.key, required this.onSubmit});

  @override
  final void Function(UserLoginForm) onSubmit;


  @override
  State<LoginForm> createState() => _LoginFormState();
  
}

class _LoginFormState extends State<LoginForm> {
  late bool _isObscure;
  late GlobalKey<FormState> _formKey;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late UserLoginForm _userLoginFormData;

  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
    _isObscure = true;
    _formKey = GlobalKey<FormState>();
    _userLoginFormData = UserLoginForm(
      email: '',
      password: '',
    );
  }

  void _hideText() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void submit(UserLoginForm userData) {
    widget.onSubmit(userData);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: ContentPadding(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  if (!_emailRegex.hasMatch(value)) {
                    return 'Por favor ingrese un correo electrónico válido';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    hintText: 'example@mail.com',
                    border: OutlineInputBorder()),
              ),
              const ItemSeparator(),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  if(value.length < 6){
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Ingrese su contraseña',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: _hideText,
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off))),
                obscureText: _isObscure,
              ),
              const ContextSeparator(),
              ActionBtn(
                  title: 'Iniciar Sesión',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _userLoginFormData = UserLoginForm(
                          email: _emailController.text,
                          password: _passwordController.text);
                      submit(_userLoginFormData);
                    }
                  },
                  fontWeight: FontWeight.bold),
            ],
          ),
        ),
      ),
    );
  }
}
