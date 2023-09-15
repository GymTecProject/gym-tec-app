import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  @override
  void initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String entered) {
    List<Map<String, dynamic>> results = [];
    if (entered.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(entered.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RU Clients',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            Colors.transparent, // .of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search Clients', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    openDialog(_foundUsers[index]);
                  },
                  child: Card(
                    key: ValueKey(_foundUsers[index]["id"]),
                    color: Theme.of(context).colorScheme.inversePrimary,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Text(_foundUsers[index]['id'].toString()),
                      title: Text(_foundUsers[index]['name']),
                      subtitle: Text(_foundUsers[index]['age'].toString()),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog(Map<String, dynamic> s) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Client: ${s['name']}"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: 10),
            Text("Age: ${s['age']}"),
          ]),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Routine'),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(onPressed: () {}, child: const Text('Measurements')),
              ],
            )
          ],
        ),
      );
}
