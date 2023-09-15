import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

// ClipRRect(
//                   borderRadius: BorderRadius.circular(500),
//                   child: Image(
//                       image: Theme.of(context).brightness == Brightness.light
//                           ? const SvgPicture.asset('assets/images/logo-gymtec-fondo-claro.svg')
//                           : const AssetImage('assets/images/logo-gymtec-fondo-oscuro.svg'))),
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
            ContentPadding(
              child: Theme.of(context).brightness == Brightness.light
                  ? SvgPicture.asset('assets/images/logo-gymtec-fondo-claro.svg', height: MediaQuery.of(context).size.height * 0.4)
                  : SvgPicture.asset('assets/images/logo-gymtec-fondo-oscuro.svg', height: MediaQuery.of(context).size.height * 0.4),
            ),
            const ContextSeparator(),
            ActionBtn(
              title: 'Iniciar Sesión',
              onPressed: navigateToLogin,
              fontWeight: FontWeight.bold,
              style: ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(200, 40)))
            ),
            const ContextSeparator(),
            ActionBtn(
              title: 'Registrarse',
              onPressed: navigateToRegister,
              fontWeight: FontWeight.bold,
              style: ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(200, 40)))
            ),
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
