import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/pages/trainer/measures/create_measures.dart';
import 'package:gym_tec/pages/trainer/trainer_page/view_measures_page.dart';
import 'package:gym_tec/pages/user/profile/measurement.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: PageBody(),
    );
  }
}

class PageBody extends StatefulWidget {
  const PageBody({super.key});
  @override

  _PageBody createState() => _PageBody();
}

class _PageBody extends State<PageBody>  {
  String _selectedOption1 = 'Opción 1';
  String _selectedOption2 = 'Opción A';
  
  //Datos personales
  final String _nombre = 'Daniel Araya Sambucci';
  final String _edad = '21';
  final String _correo = 'danielarayasambucci@gmail.com';

  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

    void _navigateToSeeMeasures(List<UserMeasurement>? m) async {
    dynamic state = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewMeasures(
            m: m,
          ),
        ));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state),
        duration: const Duration(seconds: 3),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

   void navigateToMeasurement(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MeasurementPage()));
}


    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        automaticallyImplyLeading: false,
      ),
      body: ContentPadding(
        child: Card(
          child: ContentPadding(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Align contents at the top
                crossAxisAlignment: CrossAxisAlignment.start, // Center contents horizontally
                children: [
                  const SizedBox(
                    height: 50,
                    //width: 100,
                    //color: Colors.red,
                    child: Center(child: Text('Datos personales', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 16),
                  child: Text('Nombre: $_nombre', style: const TextStyle(fontSize: 16))),
                  const Divider(),
                  Padding(padding: const EdgeInsets.only(left: 16),
                  child: Text('Edad: $_edad', style: const TextStyle(fontSize: 16))),
                  const Divider(),
                  Padding(padding: const EdgeInsets.only(left: 16),
                  child: Text('Correo electrónico: $_correo', style: const TextStyle(fontSize: 16))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
