import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {

    navigateToLogin() {
      context.push('/login');
    }

    navigateToRegister() {
      context.push('/register');
    }

    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ContentPadding(
              child: Theme.of(context).brightness == Brightness.light
                  ? SvgPicture.asset(
                      'assets/images/logo-gymtec-fondo-claro.svg',
                      height: MediaQuery.of(context).size.height * 0.4)
                  : SvgPicture.asset(
                      'assets/images/logo-gymtec-fondo-oscuro.svg',
                      height: MediaQuery.of(context).size.height * 0.4),
            ),
            const ContextSeparator(),
            ActionBtn(
                title: 'Iniciar Sesión',
                onPressed: navigateToLogin,
                fontWeight: FontWeight.bold,
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(200, 40)))),
            const ContextSeparator(),
            ActionBtn(
                title: 'Registrarse',
                onPressed: navigateToRegister,
                fontWeight: FontWeight.bold,
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(200, 40)))),
            const ContextSeparator(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Al continuar, aceptas los ",
                      style: TextStyle(
                        color: Colors.grey
                      )
                    ),
                    TextSpan(
                      text: "Términos de Uso",
                      recognizer: TapGestureRecognizer()..onTap = () => context.push('/terms-and-conditions'),
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    const TextSpan(
                      text: " y la ",
                      style: TextStyle(
                        color: Colors.grey
                      )
                    ),
                    TextSpan(
                      text: "Política de Privacidad",
                      recognizer: TapGestureRecognizer()..onTap = () => context.push('/privacy-policy'),
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    const TextSpan(
                      text: " de GymTec.",
                      style: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  ]
                ),
              )
            ),
          ]),
    ));
  }
}
