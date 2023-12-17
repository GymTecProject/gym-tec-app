import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_tec/auth/auth.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/legal/privacy_policy.dart';
import 'package:gym_tec/legal/terms_and_conditions.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
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
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
      // redirect: (context, state) => _Guards.userNotLogged(context, state),
    ),
    GoRoute(
      path: '/terms-and-conditions',
      builder: (context, state) => const TermsAndConditions(),
    ),
    GoRoute(
      path: '/privacy-policy',
      builder: (context, state) => const PrivacyPolicy(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      // redirect: (context, state) => _Guards.userNotLogged(context, state),
    ),
    GoRoute(
      path: '/register', 
      builder: (context, state) => const RegisterPage(),
      // redirect: (context, state) => _Guards.userNotLogged(context, state),
    ),
    GoRoute(
      path: '/client',
      builder: (context, state) => const UserRootPage(),
      // redirect: (context, state) => _Guards.userIsClient(context, state),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminRootPage(),
      // redirect: (context, state) => _Guards.userIsAdministrator(context, state)
    ),
    GoRoute(
      path: '/trainer',
      builder: (context, state) => const TrainerRootPage(),
      // redirect: (context, state) => _Guards.userIsTrainer(context, state)
    ),
  ]);
}

class _Guards {
  static final AuthInterface _authService = DependencyManager.authService;
  static final DatabaseInterface _dbService = DependencyManager.databaseService;

  static FutureOr<String?> userNotLogged(
      BuildContext context, GoRouterState state) async {
    final user = _authService.currentUser;

    if (user == null) {
      return null;
    }

    String userId = user.uid;
    UserPrivateData? userPrivateData =
        await _dbService.getUserPrivateData(userId);
    if (userPrivateData == null) return null;

    switch (userPrivateData.accountType) {
      case AccountType.administrator:
        return '/admin';
      case AccountType.trainer:
        return '/trainer';
      case AccountType.client:
        return '/client';
      default:
        return null;
    }
  }

  static FutureOr<String?> userIsAdministrator(
      BuildContext context, GoRouterState state) async {
    final user = _authService.currentUser;
    if (user == null) return '/auth';

    String userId = user.uid;
    UserPrivateData? userPrivateData =
        await _dbService.getUserPrivateData(userId);
    if (userPrivateData == null) return '/auth';

    if (userPrivateData.accountType == AccountType.administrator) {
      return null;
    } else {
      return '/auth';
    }
  }
    static FutureOr<String?> userIsTrainer(
      BuildContext context, GoRouterState state) async {
    final user = _authService.currentUser;
    if (user == null) return '/auth';

    String userId = user.uid;
    UserPrivateData? userPrivateData =
        await _dbService.getUserPrivateData(userId);
    if (userPrivateData == null) return '/auth';

    if (userPrivateData.accountType == AccountType.administrator) {
      return null;
    } else {
      return '/auth';
    }
  }
    static FutureOr<String?> userIsClient(
      BuildContext context, GoRouterState state) async {
    final user = _authService.currentUser;
    if (user == null) return '/auth';

    String userId = user.uid;
    UserPrivateData? userPrivateData =
        await _dbService.getUserPrivateData(userId);
    if (userPrivateData == null) return '/auth';

    if (userPrivateData.accountType == AccountType.administrator) {
      return null;
    } else {
      return '/auth';
    }
  }
}
