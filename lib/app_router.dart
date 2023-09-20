import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_tec/auth/auth.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/pages/admin/admin_root_page.dart';
import 'package:gym_tec/pages/trainer/trainer_root_page.dart';
import 'package:gym_tec/pages/user/user_root_page.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:gym_tec/splash_screen.dart';

import 'auth/login.dart';
import 'auth/register.dart';

class AppRouter {
  static final routes = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
      // redirect: (context, state) => _Guards.userLogged(context, state),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
      // redirect: (context, state) => _Guards.userLogged(context, state),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      // redirect: (context, state) => _Guards.userLogged(context, state,'/login'),
    ),
    GoRoute(
      path: '/register', builder: (context, state) => const RegisterPage(),
      // redirect: (context, state) => _Guards.userLogged(context, state,'/register')
    ),
    GoRoute(
      path: '/client',
      builder: (context, state) => const UserRootPage(),
      // redirect: (context, state) => _Guards.userNotLogged(context, state, '/client')
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminRootPage(),
      // redirect: (context, state) => _Guards.userNotLogged(context, state, '/admin')
    ),
    GoRoute(
      path: '/trainer',
      builder: (context, state) => const TrainerRootPage(),
      // redirect: (context, state) => _Guards.userNotLogged(context, state, '/trainer'),
    ),
  ]);
}

class _Guards {
  static final AuthInterface _authService = DependencyManager.authService;
  static final DatabaseInterface _dbService = DependencyManager.databaseService;

  static FutureOr<String?> userLogged(
      BuildContext context, GoRouterState state) async {

  }

  static FutureOr<String?> userNotLogged(
      BuildContext context, GoRouterState state) {}
}
