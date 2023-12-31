import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_tec/auth/password_reset.dart';

import 'package:gym_tec/forms/auth/login_form.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
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
    AccountType? account = await _authService.emailAndPasswordLogin(userData);
    if (!mounted) return;
    if (account == null) {
      showLoginError();
      return;
    };
    switch (account) {
      case AccountType.administrator:
        context.go('/admin');
        break;
      case AccountType.trainer:
        context.go('/trainer');
        break;
      case AccountType.client:
        context.go('/client');
        break;
      default:
        showLoginError();
    }
  }

  void onResetPassword() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PasswordReset()));
  }

  void showLoginError() {
    const logginErrorSnackBar = SnackBar(
      content: Text(
        'Correo o contraseña incorrectos',
      ),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(logginErrorSnackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LoginForm(
            onSubmit: onLogin,
          ),
          TextButton(
            onPressed: onResetPassword,
            child: const Text('¿Olvidaste tu contraseña?'),
          )
        ],
      ),
    ));
  }
}
