import 'package:feth_character_planner/widgets.dart';
import 'package:flutter/material.dart';
import 'package:feth_character_planner/main.dart';
import 'package:provider/provider.dart';
// import 'package:feth_character_planner/constants.dart';

// Homepage
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();


    return Scaffold(
      // Topbar
      appBar: MyTopBar(title: "Fire Emblem Three House Character Planner"),
      // Body
      body: Column(
        children: [Text('A random idea is here:'), Text(appState.current.asLowerCase),

          // ↓ Add this.
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
            },
            child: Text('Next'),
          ),  
        ],
      ),
    );
  }
}