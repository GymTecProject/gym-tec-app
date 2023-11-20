import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import '../../../interfaces/database_interface.dart';
import '../../../services/dependency_manager.dart';

enum SexOption {
  male('Masculino', Sex.male),
  female('Femenino', Sex.female),
  none('Ninguno', Sex.other);

  const SexOption(this.label, this.value);
  final String label;
  final Sex value;
}

class AdminPublicData extends StatefulWidget {
  final UserPublicData user;
  const AdminPublicData({Key? key, required this.user}) : super(key: key);

  @override
  State<AdminPublicData> createState() => _AdminPublicDataState();
}

class _AdminPublicDataState extends State<AdminPublicData> {
  final DatabaseInterface dbService = DependencyManager.databaseService;

  TextEditingController nameController = TextEditingController();
  late Sex _selectedSex;
  late DateTime selectedExpirationDate;

  void setSexSelection(Sex value) {
    setState(() {
      _selectedSex = value;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    _selectedSex = widget.user.sex;
    selectedExpirationDate = widget.user.expirationDate.toDate();
  }

  void updatePublicData() {
    final public = UserPublicData(
        id: widget.user.id,
        name: nameController.text,
        sex: _selectedSex,
        expirationDate: Timestamp.fromDate(selectedExpirationDate));
    dbService.createUserPublicData(widget.user.id, public.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.85),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton.filledTonal(
                  tooltip: 'Guardar',
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    updatePublicData(); // Save button pressed
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                IconButton.filledTonal(
                  tooltip: 'Cancelar',
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {
                    // Exit button pressed
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(
                'Datos Públicos',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre Completo',
                hintText: 'Nombre Completo',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const ItemSeparator(),
            Card(
              child: ContentPadding(
                child: Column(
                  children: [
                    const Text('Sexo'),
                    const ItemSeparator(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          clipBehavior: Clip.hardEdge,
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                              onTap: () => setSexSelection(Sex.male),
                              child: SizedBox(
                                width: 75,
                                height: 75,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Hombre'),
                                    Icon(Icons.male,
                                        color: _selectedSex == Sex.male
                                            ? Colors.blue
                                            : null),
                                  ],
                                ),
                              )),
                        ),
                        Card(
                          clipBehavior: Clip.hardEdge,
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () => setSexSelection(Sex.female),
                            child: SizedBox(
                              width: 75,
                              height: 75,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text('Mujer'),
                                  Icon(Icons.female,
                                      color: _selectedSex == Sex.female
                                          ? Colors.red
                                          : null),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                            clipBehavior: Clip.hardEdge,
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: InkWell(
                                onTap: () => setSexSelection(Sex.other),
                                child: SizedBox(
                                    width: 75,
                                    height: 75,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text('Otro'),
                                          Icon(
                                            Icons.do_not_disturb_on_outlined,
                                            color: _selectedSex == Sex.other
                                                ? Colors.amber
                                                : null,
                                          )
                                        ]))))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const ItemSeparator(),
            Expanded(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 1)),
                        lastDate: DateTime(DateTime.now().year + 5),
                      );

                      if (pickedDate != null &&
                          pickedDate != selectedExpirationDate) {
                        setState(() {
                          selectedExpirationDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Seleccionar Fecha de Expiración'),
                  ),
                  Text(
                    'Fecha de expiración: ${selectedExpirationDate.toLocal()}',
                    style: const TextStyle(color: Colors.amber),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
