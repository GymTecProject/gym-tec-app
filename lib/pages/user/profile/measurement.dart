import 'package:flutter/material.dart';

class MeasurementPage extends StatefulWidget {
  const MeasurementPage({super.key});

  @override
  State<MeasurementPage> createState() => _MeasurementPage();
}

class _MeasurementPage extends State<MeasurementPage> {
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measurements'),
      ),
      body: PageBody(),
    );
  }
}
/*
class PageBody extends StatelessWidget {
  const PageBody({super.key});
  @override

  //_PageBody createState() => _PageBody();
}*/

class PageBody extends StatelessWidget  {
  PageBody({super.key});

  final List<String> matriz = [
    'Medida',
    'Antes',
    'Ahora',
    'Resultado'
    // Agrega más datos según sea necesario
  ];
  @override
  Widget build(BuildContext context) {
  return GridView.count(
  primary: false,
  padding: const EdgeInsets.all(20),
  //crossAxisSpacing: 10,
  //mainAxisSpacing: 10,
  crossAxisCount: 4,
  childAspectRatio: (2),
  children: <Widget>[
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.green,
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text("Medida", style: TextStyle(fontSize: 16,  fontWeight: FontWeight.bold))),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.green,
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text("Antes", style: TextStyle(fontSize: 16,  fontWeight: FontWeight.bold))),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.green,
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text("Ahora", style: TextStyle(fontSize: 16,  fontWeight: FontWeight.bold))),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.green,
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text("Cambio", style: TextStyle(fontSize: 16,  fontWeight: FontWeight.bold))),
    ),


    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Peso(Kg)')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('72.8')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('73.7')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('0.90')),
    ),
    
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Grasa %')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('11.8')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('11.4')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-0.40')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Masa %')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('36.8')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('37.6')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('0.80')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Agua %')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('47.2')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('47.9')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('0.70')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('D. Ósea')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('4.23')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('4.20')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-0.03')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Grasa V.')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('3')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('2')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-1.00')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Gasto C.')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('1757')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('1779')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('22.00')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('IMC')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('24.90')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('25.20')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('0.30')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Pecho')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('100')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('96')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-4.00')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Espalda')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('40')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('38')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-2.00')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Cadera')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('80')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('82.5')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('74.50')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Cintura')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('79')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('76')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-3.00')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Gluteo')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('95')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('92.8')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-2.20')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Bícep D.')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('37.2')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('37')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-0.20')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Bícep I.')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('37.5')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('36.5')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-1.00')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Muslo D.')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('58')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('58.5')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('0.50')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Muslo I.')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('59')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('58')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-1.00')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Pantorrilla D.')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('38')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('38')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('0.00')),
    ),
    
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('Pantorrilla I.')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('39')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('37.5')),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      //color: Colors.teal[500],
      decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: const Center(child: Text('-1.50')),
    ),
  ],
);
  }
}