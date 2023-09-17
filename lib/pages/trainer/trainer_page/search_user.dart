import 'package:flutter/material.dart';
import 'package:gym_tec/pages/trainer/CRUD_routine/create_routine.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  //variables
  final List<Map<String, dynamic>> _allUsers = [
    // UserPublicData
    {
      "id": 1,
      "name": "Andy",
      "phone": "555-123-4567",
      "email": "andy@example.com"
    },
    {
      "id": 2,
      "name": "Aragon",
      "phone": "555-987-6543",
      "email": "aragon@example.com"
    },
    {
      "id": 3,
      "name": "Bob",
      "phone": "555-555-5555",
      "email": "bob@example.com"
    },
    {
      "id": 4,
      "name": "Barbara",
      "phone": "555-111-2222",
      "email": "barbara@example.com"
    },
    {
      "id": 5,
      "name": "Candy",
      "phone": "555-333-4444",
      "email": "candy@example.com"
    },
    {
      "id": 6,
      "name": "Colin",
      "phone": "555-666-7777",
      "email": "colin@example.com"
    },
    {
      "id": 7,
      "name": "Audra",
      "phone": "555-999-0000",
      "email": "audra@example.com"
    },
    {
      "id": 8,
      "name": "Banana",
      "phone": "555-888-5555",
      "email": "banana@example.com"
    },
    {
      "id": 9,
      "name": "Caversky",
      "phone": "555-222-1111",
      "email": "caversky@example.com"
    },
    {
      "id": 10,
      "name": "Becky",
      "phone": "555-777-3333",
      "email": "becky@example.com"
    },
  ];

  //age, gender, role, medical conditions, objective, expiration date
  //Dialog -> height, water, protein, minerals, fat, weight, skeletalMuscleMass, imc, fatPercentage

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
                itemBuilder: (context, index) => ExpansionTile(
                  key: ValueKey(_foundUsers[index]["id"]),
                  title: Text(_foundUsers[index]['name']),
                  subtitle: Text(
                    "Phone: ${_foundUsers[index]['phone'].toString()} - Email: ${_foundUsers[index]['email']}",
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Age: 21"),
                              Text("Gender: Male"),
                              Text("Role: Client"),
                            ],
                          ),
                          Text("Medical Conditions: None"),
                          Text("Objective: Hypertrophy"),
                          Text("Expiration Date: 20/10/2023"),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const CreateRoutinePage();
                            },
                          ),
                        );
                      },
                          child: const Text('Routine'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              openDialog(_foundUsers[index]);
                            },
                            child: const Text('Measurements')),
                      ],
                    )
                  ],
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
          content: const Column(mainAxisSize: MainAxisSize.min, children: [
            //Text("User added measurements"),
            SizedBox(height: 10),
            Text("Height: "),
            Text("Weight: "),
            Text("Water: "),
            Text("Protein: "),
            Text("Minerals: "),
            Text("Fat: "),
            Text("Skeletal Muscle Mass: "),
            Text("IMC: "),
            Text("Fat Percentage: "),
          ]),
          actions: const [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      );
}
