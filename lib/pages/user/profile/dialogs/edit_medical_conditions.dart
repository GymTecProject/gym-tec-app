import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';

class EditMedicalConditions extends StatefulWidget {
  final List<String> medicalConditions;
  final Function(List<String>) onSave;

  const EditMedicalConditions({
    super.key,
    required this.medicalConditions,
    required this.onSave,
  });

  @override
  State<EditMedicalConditions> createState() => _EditMedicalConditionsState();
}

class _EditMedicalConditionsState extends State<EditMedicalConditions> {
  final List<TextEditingController> medicalConditionsControllers = [];
  final ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _saveConditions(List<String> conditions) {
    widget.onSave(conditions);
  }

  @override
  void initState() {
    super.initState();
    for (String condition in widget.medicalConditions) {
      medicalConditionsControllers.add(TextEditingController(text: condition));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar condiciones médicas'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: BoxConstraints(
          minHeight: 100,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: medicalConditionsControllers.length,
                  separatorBuilder: (context, index) => const ItemSeparator(),
                  itemBuilder: (context, index) {
                    return TextFormField(
                      validator: (value) => value!.isEmpty
                          ? 'Por favor ingrese una condición médica'
                          : null,
                      controller: medicalConditionsControllers[index],
                      decoration: InputDecoration(
                          hintText: 'Condición médica',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  medicalConditionsControllers.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete))),
                    );
                  },
                ),
              ),
              const ItemSeparator(),
              Align(
                  // alignment: Alignment.center,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          medicalConditionsControllers
                              .add(TextEditingController(text: ''));
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeIn,
                            );
                          });
                        });
                      },
                      icon: const Icon(Icons.add)))
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ActionBtn(
            title: 'Guardar',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                List<String> conditions = [];
                for (TextEditingController controller
                    in medicalConditionsControllers) {
                  conditions.add(controller.text);
                }
                _saveConditions(conditions);
                Navigator.of(context).pop();
              }
            } )
      ],
    );
  }
}
