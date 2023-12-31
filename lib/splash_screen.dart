import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final AuthInterface authService = DependencyManager.authService;
      final DatabaseInterface dbService = DependencyManager.databaseService;

      final user = authService.currentUser;

      if (user == null) {
        context.go('/auth');
        return;
      }

      dbService.getUserPrivateData(user.uid).then((value) {
        if (value != null) {
          switch (value.accountType) {
            case AccountType.administrator:
              context.go('/admin');
              return;
            case AccountType.trainer:
              context.go('/trainer');
              return;
            case AccountType.client:
              context.go('/client');
              return;
            default:
              context.go('/auth');
              return;
          }
        } else {
          context.go('/auth');
          return;
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Theme.of(context).brightness == Brightness.light
            ? SvgPicture.asset('assets/images/logo-gymtec-fondo-claro.svg',
                height: MediaQuery.of(context).size.height * 0.6)
            : SvgPicture.asset('assets/images/logo-gymtec-fondo-oscuro.svg',
                height: MediaQuery.of(context).size.height * 0.6),
      ),
    );
  }
}
