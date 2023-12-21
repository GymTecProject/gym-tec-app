import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gym_tec/forms/auth/register_form.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/models/users/user_register_form.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthInterface authService = DependencyManager.authService;

  void showRegisterError(String message) {
    final registerErrorSnackBar = SnackBar(
      content: Text(
        message,
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(registerErrorSnackBar);
  }

  void onRegister(UserRegisterForm newUser) async {
    String? response = await authService.registerUser(newUser);
    if (!mounted) return;
    switch (response) {
      case 'success':
        context.go('/client');
        break;
      default:
        showRegisterError(response!);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Registrarse'),
            ),
            body: RegisterForm(
              onSubmit: onRegister,
            )));
  }
}
