import 'package:flutter/material.dart';

import 'package:gym_tec/components/ui/buttons/card_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';

import 'package:gym_tec/pages/trainer/trainer_page/weekly_edit.dart';
import 'package:gym_tec/pages/admin/admin_page/admin_search_user.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  static const cardData = [
    {
      'title': 'Clientes',
      'subtitle': 'Rutinas, permisos, e información',
      'imgPath': 'assets/images/h-clients.png',
      'page': AdminSearchUser(),
    },
    {
      'title': 'Seleccionar Retos Semanales',
      'subtitle': 'Editar/Establecer',
      'imgPath': 'assets/images/h1-1.png',
      'page': EditChallenges(),
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Panel de Admins',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: ContentPadding(
              child: Column(
                children: [
                  ListView.separated(
                    itemCount: cardData.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const ContextSeparator(),
                    itemBuilder: (context, index) => CardBtn(
                      title: cardData[index]['title'] as String,
                      subtitle: cardData[index]['subtitle'] as String,
                      imgPath: cardData[index]['imgPath'] as String,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return cardData[index]['page'] as Widget;
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
