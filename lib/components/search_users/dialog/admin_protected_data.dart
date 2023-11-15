import 'package:flutter/material.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import '../../../interfaces/database_interface.dart';
import '../../../services/dependency_manager.dart';

class AdminProtectedData extends StatefulWidget {
  final String uid;
  const AdminProtectedData({Key? key, required this.uid}) : super(key: key);

  @override
  State<AdminProtectedData> createState() => _AdminProtectedDataState();
}

class _AdminProtectedDataState extends State<AdminProtectedData> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  UserProtectedData? _userProtectedData;

  TextEditingController emailController = TextEditingController();
  TextEditingController objectiveController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late List<TextEditingController> medicalControllers;
  late List<String>? medicalConditions;

  @override
  void initState() {
    super.initState();
    medicalConditions = [];
    _getUserProtectedData();
  }

  void _getUserProtectedData() async {
    UserProtectedData? userProtectedData =
        await dbService.getUserProtectedData(widget.uid);
    if (userProtectedData != null) {
      setState(() {
        _userProtectedData = userProtectedData;
        emailController =
            TextEditingController(text: _userProtectedData?.email);
        objectiveController =
            TextEditingController(text: _userProtectedData?.objective);
        phoneController =
            TextEditingController(text: _userProtectedData?.phoneNumber);
        medicalConditions = _userProtectedData?.medicalConditions;
        medicalControllers = List.generate(medicalConditions!.length,
            (index) => TextEditingController(text: medicalConditions?[index]));
      });
    }
  }

  void updateProtectedData() {
    List<String> medicalText =
        medicalControllers.map((controller) => controller.text).toList();
    final protected = UserProtectedData(
        id: widget.uid,
        email: emailController.text,
        phoneNumber: phoneController.text,
        medicalConditions: medicalText,
        objective: objectiveController.text);
    dbService.createUserProtectedData(widget.uid, protected.toJson());
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
                    updateProtectedData(); // Save button pressed
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
                'Datos Protegidos',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo',
                    hintText: 'Correo',
                    prefixIcon: Icon(Icons.mail),
                  ),
                ),
                const ItemSeparator(),
                TextFormField(
                  controller: objectiveController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Objetivo',
                    hintText: 'Objetivo',
                    prefixIcon: Icon(Icons.star),
                  ),
                ),
                const ItemSeparator(),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Teléfono',
                    hintText: 'Teléfono',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                const ItemSeparator(),
              ],
            ),
            Expanded(
              child: medicalConditions!.isNotEmpty
                  ? ListView.builder(
                      itemCount: medicalConditions!.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          TextFormField(
                            controller: medicalControllers[index],
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Condición Medica ${index + 1}',
                              hintText: 'Condición Medica ${index + 1}',
                              prefixIcon: const Icon(Icons.medical_services),
                            ),
                          ),
                          const ItemSeparator(),
                        ],
                      ),
                    )
                  : TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Condición Medica',
                        hintText: 'Condición Medica',
                        prefixIcon: Icon(Icons.medical_services),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
