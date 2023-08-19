import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    navigateToLogin() {
      Navigator.pushNamed(context, '/login');
    }

    navigateToRegister() {
      Navigator.pushNamed(context, '/register');
    }

    const String termsAndPrivacy =
        "Al continuar, aceptas los Términos de Uso y la Política de Privacidad de GymTec.";

    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: const Image(
                      image: AssetImage('assets/images/gym_tec_logo.png'))),
            ),
            const ContextSeparator(),
            FilledButton(
                onPressed: navigateToLogin,
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(200, 40))),
                child: const Text('Iniciar Sesión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            const ContextSeparator(),
            FilledButton(
                onPressed: navigateToRegister,
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(200, 40))),
                child: const Text('Registrarse', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            const ContextSeparator(),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                termsAndPrivacy,
                style: TextStyle(fontSize: 12, color: Colors.grey),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
    ));
  }
}
