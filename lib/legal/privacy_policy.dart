import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
                    Text("Política de Privacidad",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    ContextSeparator(),
                    Text(
                        "1. Al registrarse en la aplicación, se recopilará información personal que puede incluir, pero no se limita a: medidas biométricas, condiciones médicas, sexo, edad y datos de contacto."),
                    ItemSeparator(),
                    Text(
                        "2. La información médica se recopila con el fin exclusivo de personalizar y adaptar las rutinas de entrenamiento según las necesidades y limitaciones de salud de cada usuario."),
                    ItemSeparator(),
                    Text(
                        "3. Se implementarán medidas de seguridad técnicas y organizativas para proteger la información recopilada de acceso no autorizado o de su alteración, divulgación o destrucción accidental."),
                    ItemSeparator(),
                    Text(
                        "4. A pesar de todas las precauciones tomadas, la transmisión de información a través de internet no es completamente segura y, por lo tanto, no se puede garantizar la seguridad absoluta de los datos transmitidos."),
                    ItemSeparator(),
                    Text(
                        "5.  Los usuarios tienen derecho a acceder, rectificar, actualizar o solicitar la eliminación de su información personal almacenada en la Aplicación"),
                    ItemSeparator(),
                    Text(
                        "6. Para ejercer estos derechos o realizar consultas sobre la información almacenada, los usuarios pueden ponerse en contacto con la administracion de GymTec"),
                    ItemSeparator(),
                    Text(
                        "7. La version web de la aplicación utiliza cookies u otras tecnologías similares para mejorar la experiencia del usuario."
                    ),
                    ItemSeparator(),
                    Text(
                      "8. Gym Tec se reserva el derecho de actualizar esta Política de Privacidad en cualquier momento. Los usuarios serán notificados sobre cambios significativos en la gestión de la información personal."
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
