import 'package:flutter/material.dart';

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
    Navigator.pushNamed(context, '/user');
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                    hintText: 'Alex'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Apellido',
                    hintText: 'Gonzalez'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo',
                    hintText: 'example@email.com'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Enter your password',
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
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: _hideText,
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off))),
                obscureText: _isObscure,
              ),
              const SizedBox(height: 20.0),
              FilledButton(
                  onPressed: onNavigateToUser,
                  child: const Text('Registrarse')),
            ]),
      ),
    )));
  }
}
