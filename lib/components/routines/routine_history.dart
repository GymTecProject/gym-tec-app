import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/services/dependency_manager.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RoutineHistoryDialog extends StatefulWidget {
  final String uid;

  const RoutineHistoryDialog({
    super.key,
    required this.uid,
  });

  @override
  State<RoutineHistoryDialog> createState() => _RoutineHistoryDialogState();
}

class _RoutineHistoryDialogState extends State<RoutineHistoryDialog> {
  final DatabaseInterface dbService = DependencyManager.databaseService;

  late List<RoutineData> routineHistory = [];

  void _fetchRoutineHistory()async {
    final routineHistoryData = await dbService.getUserRoutines(widget.uid, 10);
    if (routineHistoryData == null) {
      routineHistory = [];
      return;
    }
    setState(() {
      routineHistory = routineHistoryData;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRoutineHistory();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Historial de rutinas'),
        content: Skeletonizer(
          enabled: routineHistory.isEmpty,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Expanded(
                    child:
                    routineHistory.isNotEmpty?
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          title: Text(DateFormat('dd/MM/yyyy').format(routineHistory[index].date.toDate())),
                          onTap: () => Navigator.of(context).pop(routineHistory[index]),
                        ),
                      ), 
                      separatorBuilder: (context, index) => const ItemSeparator(), 
                      itemCount: routineHistory.length
                    )
                    :ListView.separated(
                      shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(title: Text('Rutina ${index + 1}')),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const ItemSeparator();
                        },
                        itemCount: 10))
              ],
            ),
          ),
        ));
  }
}
