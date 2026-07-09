import 'package:feth_character_planner/widgets.dart';
import 'package:flutter/material.dart';
import 'package:feth_character_planner/main.dart';
import 'package:provider/provider.dart';
import 'package:feth_character_planner/themes.dart';

// Homepage
class MyHomePage extends StatelessWidget {
  // routeName for current page checking
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      // Topbar
      appBar: MyTopBar(
        title: "Fire Emblem Three House Character Planner",
        height: AppSizes.topBarHeight(context), // in themes.dart - 8% of screen size
      ),

      // Body
      body: Column(
        children: [
          Text('A random idea is here:'),
          Text(appState.current.asLowerCase),

          // ↓ Add this.
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
              context.read<ThemeManager>().setTheme("royalPurple");
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}