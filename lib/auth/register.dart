import 'package:flutter/material.dart';

import '../components/ui/buttons/action_btn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;

  void _hideText() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void onNavigateToUser() {
    Navigator.pushNamed(context, '/trainer');
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
                decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Nombre',
                    hintText: 'Alex',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Apellido',
                    hintText: 'Gonzalez',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Correo',
                    hintText: 'example@email.com',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: _hideText,
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off))),
                obscureText: _isObscure,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: _hideText,
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off))),
                obscureText: _isObscure,
              ),
              const SizedBox(height: 20.0),
              ActionBtn(title: 'Registrarse', onPressed: onNavigateToUser, fontWeight: FontWeight.bold),
            ]),
      ),
    )));
  }
}
