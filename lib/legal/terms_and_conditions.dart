import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Términos de Uso'),
        ),
        body: const ContentPadding(
          child: Card(
            child: ContentPadding(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Términos de Uso',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ContextSeparator(),
                    Text(
                      "1 Gym Tec cuenta con personal calificado y certificado, para guiarlo y apoyarlo,en el desarrollo de sus rutinas y planes de entrenamiento.",
                    ),   
                    ItemSeparator(),
                    Text(
                      "2 El cliente debe respetar las normas de convivencia y comportamiento, dentro de las instalaciones del gimnasio.",
                    ),
                    ItemSeparator(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
