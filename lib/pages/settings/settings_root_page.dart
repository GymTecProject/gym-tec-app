import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/pages/settings/error_report/error_report_page.dart';

import '../../services/dependency_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthInterface authService = DependencyManager.authService;

  @override
  Widget build(BuildContext context) {
    final List settingsList = [
      {
        'title': 'Reportar Error',
        'icon': Icons.error,
        'onPressed': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ErrorReportPage(),
            ),
          );
        }
      },
      {
        'title': 'Términos de Uso',
        'icon': Icons.description,
        'onPressed': () {
          context.push('/terms-and-conditions');
        }
      },
      {
        'title': 'Política de Privacidad',
        'icon': Icons.privacy_tip,
        'onPressed': () {
          context.push('/privacy-policy');
        }
      },
      {
        'title': 'Cerrar Sesión',
        'icon': Icons.logout,
        'onPressed': () {
          authService.logout();
          context.go('/');
        }
      }
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Ajustes'),
          automaticallyImplyLeading: false,
        ),
        body: ContentPadding(
            child: Card(
              clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: settingsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(settingsList[index]['title']),
                    leading: Icon(
                      settingsList[index]['icon'],
                      color: settingsList[index]['title'] == 'Cerrar Sesión'
                          ? Colors.red
                          : null,
                    ),
                    onTap: settingsList[index]['onPressed'],
                    textColor: settingsList[index]['title'] == 'Cerrar Sesión'
                        ? Colors.red
                        : null,
                  );
                },
              )),
            ],
          ),
        )));
  }
}
