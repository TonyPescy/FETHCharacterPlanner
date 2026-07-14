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
                  debugPrint('Create Character Plan Home Button Pressed');
                  // Navigate to 'Create Character Plan' page
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const CreateSingleCharPage(),
                    ),
                  );
                },
              ),

              homeButton(
                context: context,
                size: buttonSize,
                icon: Icons.home,
                text: "Create House Plan",
                onPressed: () {
                  debugPrint('Create House Plan Home Button Pressed');
                  // Navigate to 'Create House Plan' page
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const CreateHousePlanPage(),
                    ),
                  );
                },
              ),

              homeButton(
                context: context,
                size: buttonSize,
                icon: Icons.groups,
                text: "Manage Plans",
                onPressed: () {
                  debugPrint('Manage Plans Home Button Pressed');
                  // Navigate to 'Manage Plans' page
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const MyPlansPage(),
                    ),
                  );
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
    //var appState = context.watch<MyAppState>();

    // Variables for use in styling and theming
    final theme = context.watch<ThemeManager>().currentTheme;

    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;

    // Button is 28% of the smaller screen dimension, max 200px.
    //final buttonSize = math.min(math.min(screenWidth, screenHeight) * 0.28, 400.0);

    // Spacing scales with screen size.
    final spacing = math.min(screenWidth * 0.04, 40.0);

    return Scaffold(
      // Styling
      // Themes
      backgroundColor: theme.secondary,
      // Topbar
      appBar: MyTopBar(
        title: "My Fire Emblem Three House Plans",
        height: AppSizes.topBarHeight(context), // in themes.dart - 8% of screen size
      ),

      // Body
      body: Center(
        child : Padding(
          padding: EdgeInsets.all(spacing),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return planDisplayCard(context: context);
            },
            shrinkWrap: true,
            // Divider between list items
            separatorBuilder: (context, index) => Divider(
              color: theme.background,
              thickness: 1.0,
            ),
            // Number of items in the list
            itemCount: 10, // REPLACE WITH NUMBER OF PLANS FROM TXT/JSON
          )
        )
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


// CreateHousePlanPage Start
  class CreateHousePlanPage extends StatelessWidget {
    const CreateHousePlanPage({super.key});
    // routeName for current page checking
    static const routeName = "/create_house_plan";
    
      @override
      Widget build(BuildContext context) {
      //\ implement build
    throw UnimplementedError();
      }
  }
// CreateHousePlanPage End

// ViewHousePlansPage Start
  class ViewHousePlansPage extends StatelessWidget {
    const ViewHousePlansPage({super.key});
    // routeName for current page checking
    static const routeName = "/view_house_plan";

    @override
      Widget build(BuildContext context) {
      //\ implement build
    throw UnimplementedError();
      }
  }
// ViewHousePlansPage End

// ViewCharPlansPage Start
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
// ViewCharPlansPage End