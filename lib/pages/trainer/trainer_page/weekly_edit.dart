import 'package:flutter/material.dart';

class EditChallenges extends StatefulWidget {
  const EditChallenges({super.key});

  @override
  State<EditChallenges> createState() => _EditChallengesState();
}

class _EditChallengesState extends State<EditChallenges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Weekly Challenges'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }         
}