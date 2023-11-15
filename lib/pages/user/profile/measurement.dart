import 'package:flutter/material.dart';
import '/components/profile/measurement_Item.dart';

List<MeasurementItem> generateItems(int numberOfItems) {
  return List<MeasurementItem>.generate(numberOfItems, (int index) {
    return MeasurementItem(
      id: index,
      headerValue: 'Panel $index',
      expandedValue: 'Este es el detalle del panel $index',
    );
  });
}

class MyCollapsibleList extends StatefulWidget {
  const MyCollapsibleList({super.key});

  @override
  State<MyCollapsibleList> createState() => _MyCollapsibleListState();
}

class _MyCollapsibleListState extends State<MyCollapsibleList> {
  final List<MeasurementItem> _data = generateItems(8);

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      children: _data.map<ExpansionPanelRadio>((MeasurementItem item) {
        return ExpansionPanelRadio(
          value: item.id,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
            onTap: () {
              Navigator.pop(context, item.id);
            },
          ),
        );
      }).toList(),
    );
  }

    @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }
}
class MeasurementPage extends StatefulWidget {
  const MeasurementPage({super.key});

  @override
  _MeasurementPage createState() => _MeasurementPage();
}


class _MeasurementPage extends State<MeasurementPage> {
 
  Future<void> _showSelectionModal(BuildContext context) async {
    int? selectedValue = await showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return const MyCollapsibleList(); 
      },
    );

    if (selectedValue != null) {
      print('El valor seleccionado es $selectedValue');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measurements'),
        actions: <Widget>[
          TextButton(
            onPressed: () => _showSelectionModal(context),
            child: const Text(
              'Comparar medidas',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 98, 3), // Color del texto del botón
              ),
            ),
          ),
        ],
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
  children: const <Widget>[
  ],
);
  }
}