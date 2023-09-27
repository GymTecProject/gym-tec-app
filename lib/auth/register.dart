import 'package:flutter/material.dart';
import 'package:gym_tec/forms/auth/register_form.dart';
import 'package:gym_tec/models/users/user_register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void onNavigateToUser() {
    Navigator.pushNamed(context, '/trainer');
  }

  void onRegister(UserRegisterForm newUser) {

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
