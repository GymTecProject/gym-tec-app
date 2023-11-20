import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class ExercisePage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String url;
  final String comment;
  final String category;
  final int series;
  final int repetitions;
  final num weight;
  
  const ExercisePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.comment,
    required this.category,
    required this.series,
    required this.repetitions,
    required this.weight,
  });

  @override
  State<ExercisePage> createState() => _ExercisePage();
  }

class _ExercisePage extends State<ExercisePage> {
  final TextEditingController _weightController = TextEditingController();
  final DatabaseInterface dbService = DependencyManager.databaseService;

  Future<void> _launchURL() async {
    final Uri url = Uri.parse("https://www.youtube.com/watch?v=sXi4xP8w2UM");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      print("Se abrió el navegador");
    } else {
      // Aquí puedes manejar el error o mostrar un mensaje si el enlace no se puede abrir.
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.weight != 0) {
    _weightController.text = widget.weight.toString();
  }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //function
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise Details'),
        ),
        body: ContentPadding(
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.fitness_center), // Ícono que deseas usar
                  title: Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(widget.subtitle, style: const TextStyle(fontSize: 14)),
                ),
              ),
              const ItemSeparator(),
              Card(
                child: ListTile(
                  leading: Icon(Icons.repeat_on),
                  title: const Text("Series", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text("${widget.series.toString()}", style: const TextStyle(fontSize: 14)),
                ),
              ),
              const ItemSeparator(),
              Card(
                child: ListTile(
                  leading: Icon(Icons.replay),
                  title: const Text("Repeticiones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(widget.repetitions.toString(), style: const TextStyle(fontSize: 14)),
                ),
              ),
              const ItemSeparator(),
              Card(
                child: ListTile(
                  leading: Icon(Icons.speaker_notes),
                  title: const Text("Comentarios", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(widget.comment.isNotEmpty ? widget.comment : "Ninguno", style: const TextStyle(fontSize: 14)),
                ),
              ),
              const ItemSeparator(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller:
                      _weightController,
                    keyboardType:
                      TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration:
                      const InputDecoration(
                    prefixIcon: Icon(
                      Icons.scale),
                        labelText: 'Peso',
                        hintText: 'Ej: 30',
                        border:
                        OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ActionBtn(title: "Ver video", onPressed: ()=>{_launchURL()}, fontWeight: FontWeight.bold),
              ),
            ],
              ),)
      ),
    );
  }
}
