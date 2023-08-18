import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;

  void _hideText() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void onNavigateToUser() {
    Navigator.pushNamed(context, '/user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'example@mail.com',
                  border: OutlineInputBorder()),
            ),
            const ItemSeparator(),
            TextFormField(
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
            FilledButton(
              onPressed: onNavigateToUser,
              child: const Text('Login'),
            )
          ],
        ),
      )),
    );
  }
}
