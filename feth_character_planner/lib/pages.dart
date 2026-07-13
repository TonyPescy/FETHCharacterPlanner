import 'package:feth_character_planner/widgets.dart';
import 'package:flutter/material.dart';
import 'package:feth_character_planner/main.dart';
import 'package:provider/provider.dart';
import 'package:feth_character_planner/themes.dart';
import 'dart:math' as math;

// Homepage Start
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  // routeName for current page checking
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    // Screen size for button sizing
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // 33% of the smaller screen dimension, max 200px.
    double buttonSize = math.min( math.min(screenWidth, screenHeight) * 0.33, 200);


    return Scaffold(
      // Topbar
      appBar: MyTopBar(
        title: "Fire Emblem Three House Character Planner",
        height: AppSizes.topBarHeight(context), // in themes.dart - 8% of screen size
      ),

      // Body
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row 1
            Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                // Create Character plan
                SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: ElevatedButton(
                    onPressed: () {
                      // Your action
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home, size: 48),   // NEEDS BETTER ICONS FOR THIS
                        SizedBox(height: 12),
                        Text(
                          'Create Character Plan',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                // Create House Plan
                SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: ElevatedButton(
                    onPressed: () {
                      // Your action
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home, size: 48),   // NEEDS BETTER ICONS FOR THIS
                        SizedBox(height: 12),
                        Text(
                          'Create House Plan',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
                  // Row 2
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Create House Plan
                      Text('This will be button 2:'),
                      Text(appState.current.asLowerCase),

                      // ↓ Add this.
                      ElevatedButton(
                        onPressed: () {
                          print('');
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const MyPlansPage(),
                            ),
                          );
                        },
                        child: Text('Next2'),
                      ),
                    ],
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

// CreateSingleCharPage Start
  class CreateSingleCharPage extends StatelessWidget {
    const CreateSingleCharPage({super.key});
    // routeName for current page checking
    static const routeName = "/create_single_char";
    
      @override
      Widget build(BuildContext context) {
      //\ implement build
    throw UnimplementedError();
      }
  }
// CreateSingleCharPage End


// CreateHousePlan Start
  class CreateHousePlan extends StatelessWidget {
    const CreateHousePlan({super.key});
    // routeName for current page checking
    static const routeName = "/create_house_plan";
    
      @override
      Widget build(BuildContext context) {
      //\ implement build
    throw UnimplementedError();
      }
  }
// CreateHousePlan End

// ViewHousePlans Start
  class ViewHousePlans extends StatelessWidget {
    const ViewHousePlans({super.key});
    // routeName for current page checking
    static const routeName = "/view_house_plan";

    @override
      Widget build(BuildContext context) {
      //\ implement build
    throw UnimplementedError();
      }
  }
// ViewHousePlans End

// ViewCharPlans Start
  class ViewCharPlans extends StatelessWidget {
    const ViewCharPlans({super.key});
    // routeName for current page checking
    static const routeName = "/view_char_plan";

    @override
      Widget build(BuildContext context) {
      //: implement build
    throw UnimplementedError();
      }
  }
// ViewCharPlans End