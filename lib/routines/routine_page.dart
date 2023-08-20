import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/RoutineButton.dart';
import 'package:gym_tec/routines/routine_data.dart';
import 'package:gym_tec/routines/routine_daY.dart';

class RoutinePage extends StatelessWidget {
  RoutinePage({Key? key}) : super(key: key);

  static const String date = 'MONDAY, SEPTEMBER 11';

  // Define una lista de datos para tus botones
  final List<RoutineData> routines = [
    RoutineData(title: 'Día 1', subtitle: 'Tren inferior', imgPath: 'assets/images/h1-1.png'),
    RoutineData(title: 'Día 2', subtitle: 'Tren superior', imgPath: 'assets/images/h1-1.png'),
    RoutineData(title: 'Día 3', subtitle: 'Tren superior', imgPath: 'assets/images/h1-1.png')
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Aquí puedes personalizar el AppBar según tus necesidades
        title: Text('Your daily routines:'),
        // Agrega un botón de regreso en la AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Agrega aquí la lógica para regresar a la pantalla de inicio
            // Puedes utilizar Navigator.pop() para regresar a la pantalla anterior
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 50.0),
              child: Text(
                'Here is your routine:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: ListView.separated(
                itemCount: routines.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 16.0), // Espacio entre botones
                itemBuilder: (BuildContext context, int index) {
                  return RoutineButton(
                    title: routines[index].title,
                    subtitle: routines[index].subtitle,
                    imgPath: routines[index].imgPath,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return RoutineDay();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class RoutinePage extends StatelessWidget {
  const RoutinePage({Key? key}) : super(key: key);

  static const String date = 'MONDAY, SEPTEMBER 11';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Aquí puedes personalizar el AppBar según tus necesidades
        title: Text('Your daily routines:'),
        // Agrega un botón de regreso en la AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Agrega aquí la lógica para regresar a la pantalla de inicio
            // Puedes utilizar Navigator.pop() para regresar a la pantalla anterior
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 50.0),
              child: Text(
                'Here is your routine:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                RoutineButton(
                  title: 'Dia 1', 
                  subtitle: 'Tren inferior', 
                  imgPath: 'assets/images/h1-1.png', 
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const RoutineDay();
                        },
                      ),
                    );
                  },
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
*/