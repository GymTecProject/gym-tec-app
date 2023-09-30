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

  void onRegister(UserRegisterForm newUser) async {
    String? uid = await authService.registerUser(newUser);
    if(!mounted) return;
    if (uid != null) {
      context.go('/client');
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
