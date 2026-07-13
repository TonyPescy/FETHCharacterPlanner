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
    // Keep this if you're using it elsewhere
    context.watch<MyAppState>();
    // Get Theme
    final theme = context.watch<ThemeManager>().currentTheme;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Button is 28% of the smaller screen dimension, max 200px.
    final buttonSize = math.min(math.min(screenWidth, screenHeight) * 0.28, 400.0);

    // Spacing scales with screen size.
    final spacing = math.min(screenWidth * 0.04, 40.0);

    return Scaffold(
      // Themes
      backgroundColor: theme.secondary,

      appBar: MyTopBar(
        title: "Fire Emblem Three House Character Planner",
        height: AppSizes.topBarHeight(context),
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: [
              homeButton(
                context: context,
                size: buttonSize,
                icon: Icons.person,
                text: "Create Character Plan",
                onPressed: () {
                  //
                },
              ),

              homeButton(
                context: context,
                size: buttonSize,
                icon: Icons.home,
                text: "Create House Plan",
                onPressed: () {
                  //
                },
              ),

              homeButton(
                context: context,
                size: buttonSize,
                icon: Icons.groups,
                text: "Manage Plans",
                onPressed: () {
                  //
                },
              ),
            ],
          ),
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