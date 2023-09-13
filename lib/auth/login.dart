import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/models/users/user_login_form.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthInterface _authService;
  late bool _isObscure;
  late UserLoginForm _userLoginForm;

  @override
  void initState() {
    super.initState();
    _isObscure = true;
    _authService = DependencyManager.authService;
    _userLoginForm = UserLoginForm(
      email: '',
      password: '',
    );
  }

  void _hideText() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  onLogin() async {
    print('${_userLoginForm.email} ${_userLoginForm.password}');
    var cred = await _authService.emailAndPasswordLogin(_userLoginForm);
    if (!mounted) return;
    if (cred != null) Navigator.pushNamed(context, '/user');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              onChanged: (value) => _userLoginForm.email = value,
              decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'example@mail.com',
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                  border: const OutlineInputBorder()),
            ),
            const ItemSeparator(),
            TextFormField(
              onChanged: (value) => _userLoginForm.password = value,
              decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Ingrese su contraseña',
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
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
                onPressed: onLogin,
                fontWeight: FontWeight.bold),
          ],
        ),
      )),
    ));
  }
}
