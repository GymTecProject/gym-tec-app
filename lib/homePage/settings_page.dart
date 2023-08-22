import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';

const int itemCount = 20;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentPadding(
      child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('Item ${(index + 1)}'),
              leading: const Icon(Icons.person),
              trailing: const Icon(Icons.select_all),
            );
          }),
    );
  }
}
