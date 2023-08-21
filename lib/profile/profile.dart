import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';

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

  //Parámetros biométricos
  /*String _altura = 
  String _peso
  String _porcentajeGrasa
  String _mMuscular
  String _mOsea
  String _gastoCalorico
  String _grasaVisceral
  String _IMC 

  //Mediciones
*/
  @override
  Widget build(BuildContext context) {

    navigateToMeasurement() {
      Navigator.pushNamed(context, '/measurement');
    }


    return ContentPadding(
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
            
            SizedBox(
              height: 75,
              child: Center(child: FilledButton(onPressed: (){}, child: const Text('Cambiar contraseña'))),
            ),
    
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: SizedBox( height: 50,
                child: Center(child:Text('Mediciones', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))  
              )),
            Center(child: Container(
              constraints: const BoxConstraints(maxWidth: 450), // Ajusta el ancho máximo del texto
              child: const Center(child: Text('Seleccione una fecha para visualizar sus mediciones o dos fechas para compararlas', style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              ),
            )),
            Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: DropdownButton<String>(
                      value: _selectedOption1,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption1 = newValue!;
                        });
                      },
                      items: <String>[
                        'Opción 1',
                        'Opción 2',
                        'Opción 3',
                        'Opción 4',
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const SizedBox(width: 16), // Espacio entre los DropdownButton
                  SizedBox(
                    width: 150,
                    child: DropdownButton<String>(
                      value: _selectedOption2,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption2 = newValue!;
                        });
                      },
                      items: <String>[
                        'Opción A',
                        'Opción B',
                        'Opción C',
                        'Opción D',
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 75,
            child: Center(child: FilledButton(onPressed: navigateToMeasurement, child: const Text('Visualizar'))),
          )],
        ),
      ),
    );
  }
}