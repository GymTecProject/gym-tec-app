import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class ErrorReportPage extends StatefulWidget {
  const ErrorReportPage({super.key});

  @override
  State<ErrorReportPage> createState() => _ErrorReportPageState();
}

class _ErrorReportPageState extends State<ErrorReportPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

    DatabaseInterface dbService = DependencyManager.databaseService;
    AuthInterface authService = DependencyManager.authService;

    void sendReport()async {
      if (formKey.currentState!.validate()) {
        await dbService.addErrorReport(authService.currentUser!.uid, _descriptionController.text);
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reporte enviado, gracias por tu ayuda')),
        );
        Navigator.of(context).pop();
      }
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Reportar Error'),
        ),
        body: Center(
          child: ContentPadding(
            child: Card(
              child: ContentPadding(
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 10,
                          maxLength: 800,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Descripción del error',
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText:
                                  "Ingrese una descripción del error: \n - ¿Qué estaba haciendo cuando ocurrió el error? \n - ¿Qué error ocurrió? \n - ¿Qué esperaba que ocurriera? \n\nEntre más información nos proporcione, más rápido podremos solucionar el problema."),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese una descripción';
                            }
                            if(value.length < 90){
                              return 'Al menos 90 caracteres';
                            }
                            return null;
                          },
                        ),
                        const ContextSeparator(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ActionBtn(title: "Enviar", onPressed: sendReport)
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ));
  }
}
