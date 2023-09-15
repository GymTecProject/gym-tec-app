import 'package:flutter/material.dart';

import 'package:gym_tec/forms/auth/login_form.dart';
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

  @override
  void initState() {
    super.initState();
    _authService = DependencyManager.authService;
  }

  void onLogin(UserLoginForm userData) async {
    var cred = await _authService.emailAndPasswordLogin(userData);
    if (!mounted) return;
    if (cred == null) showLoginError();
    Navigator.pushNamed(context, '/user');
  }

  void showLoginError() {
    final logginErrorSnackBar = SnackBar(
      content: Text(
        'Correo o contraseña incorrectos',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(logginErrorSnackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: LoginForm(
          onSubmit: onLogin,
        ),
      )),
    ));
  }
}
