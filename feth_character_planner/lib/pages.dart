import 'package:feth_character_planner/widgets.dart';
import 'package:flutter/material.dart';
import 'package:feth_character_planner/main.dart';
import 'package:provider/provider.dart';
import 'package:feth_character_planner/themes.dart';

// Homepage Start
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
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
      body: Center(
       child: Column( 
          children: [
            Text('A random idea is here:'),
            Text(appState.current.asLowerCase),

            // ↓ Add this.
            ElevatedButton(
              onPressed: () {
                print('button pressed!');
                context.read<ThemeManager>().setTheme("royalPurple");
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const MyPlansPage(),
                  ),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
// Homepage End

// PlansPage Start
class MyPlansPage extends StatelessWidget {
  const MyPlansPage({super.key});
  // routeName for current page checking
  static const routeName = "/plans";

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      // Topbar
      appBar: MyTopBar(
        title: "My Fire Emblem Three House Character Plans",
        height: AppSizes.topBarHeight(context), // in themes.dart - 8% of screen size
      ),

      // Body
      body: Column(
        children: [
          Text('PLAN PAGE!:'),
          Text(appState.current.asLowerCase),

          // ↓ Add this.
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
              context.read<ThemeManager>().setTheme("Forest");
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const MyHomePage(),
                  ),
                );
              },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
// Plans Page End