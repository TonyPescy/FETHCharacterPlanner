import 'package:flutter/material.dart';
import 'package:feth_character_planner/themes.dart';
import 'package:feth_character_planner/pages.dart';
import 'package:provider/provider.dart';
//import 'dart:convert';

// Topbar class
class MyTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Current page name
  final double height;      // Height based on media query

  // List containing pages that will confirm that the user wishes to go to homepage - Used on editing pages (create character, create house, etc...)
  final confirmMsgPages = [
    "none",
    "noneTwo"
    // USED AS SUCH: EditPage1.routeName, EditPage2.routeName...
  ];

  MyTopBar({
    super.key,
    required this.title,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeManager>().currentTheme;

    return SafeArea(
      child: Container(
        color: theme.surface,
        height: height,
        child: Row(
          children: [

            // Left - Home button/icon
            Expanded(
              flex: 1,
              child: SizedBox(
                width: height,
                height: height,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: SizedBox(
                    width: AppSizes.topBarIcon(context),
                    height: AppSizes.topBarIcon(context),
                    child: Image.asset(
                      "assets/images/crest_of_flames.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the homepage when pressed
                    // Depending on the page you are on, it will ask for confirmation (used for editing pages etc)
                    // NEEDS IMPLEMENTATION
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const MyHomePage(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Middle - Title section
            Expanded(
              flex: 8,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppTextSizes.title(context),
                    color: theme.text  
                  ),
                ),
              ),
            ),

            // Right - Settings
            Expanded(
              flex: 1,
              child: LayoutBuilder(
                builder: (context, constraints) {

                  final menuWidth = constraints.maxWidth;
                  final menuHeight = height * 0.5;   // Half the height of the topbar
                  //final numOfMenuItems = 3;         // Settings, themes, about
                  //final numOfMenuDividers = 1;      // 1 divider

                  debugPrint("Topbar height: $height");
                  debugPrint("Menu width: ${constraints.maxWidth}");

                  return MenuTheme(
                    data: MenuThemeData(
                      style: MenuStyle(
                        backgroundColor: WidgetStatePropertyAll(theme.primary),
                        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
                        elevation: const WidgetStatePropertyAll(8),

                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    child: MenuAnchor(
                      // Center menu underneath settings icon
                      alignmentOffset: Offset(0, -MediaQuery.of(context).padding.top),

                      menuChildren: [
                        SizedBox(
                            width: menuWidth,
                            
                            child: Column(
                              mainAxisSize: MainAxisSize.min,

                              children: [

                                MenuItemButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(theme.primary),
                                    foregroundColor: WidgetStatePropertyAll(theme.text),

                                    minimumSize: WidgetStatePropertyAll(
                                      Size(menuWidth, menuHeight),
                                    ),
                                  ),

                                  onPressed: () {
                                    debugPrint("Settings");
                                  },

                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Settings",
                                      style: TextStyle(
                                        fontSize: AppTextSizes.caption(context),
                                        color: theme.text,
                                      ),
                                    ),
                                  ),
                                ),


                                SubmenuButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(theme.primary),
                                    foregroundColor: WidgetStatePropertyAll(theme.text),

                                    minimumSize: WidgetStatePropertyAll(
                                      Size(menuWidth, menuHeight),
                                    ),
                                  ),

                                  menuChildren: context.read<ThemeManager>().getThemes().entries.map((entry) {

                                    return MenuItemButton(
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(theme.primary),
                                        foregroundColor: WidgetStatePropertyAll(theme.text),

                                        minimumSize: WidgetStatePropertyAll(
                                          Size(menuWidth, menuHeight),
                                        ),
                                      ),

                                      onPressed: () {
                                        context.read<ThemeManager>().setTheme(entry.key);
                                      },

                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          entry.key,
                                          style: TextStyle(
                                            fontSize: AppTextSizes.caption(context),
                                            color: theme.text,
                                          ),
                                        ),
                                      ),
                                    );

                                  }).toList(),

                                  child: Text(
                                    "Themes",
                                    style: TextStyle(
                                      fontSize: AppTextSizes.caption(context),
                                      color: theme.text,
                                    ),
                                  ),
                                ),


                                const Divider(height: 1),


                                MenuItemButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(theme.primary),
                                    foregroundColor: WidgetStatePropertyAll(theme.text),

                                    minimumSize: WidgetStatePropertyAll(
                                      Size(menuWidth, menuHeight),
                                    ),
                                  ),

                                  onPressed: () {
                                    debugPrint("About");
                                  },

                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "About",
                                      style: TextStyle(
                                        fontSize: AppTextSizes.caption(context),
                                        color: theme.text,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],


                      builder: (context, controller, child) {
                        return SizedBox(
                          height: height,

                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),

                            icon: Icon(
                              Icons.settings,
                              color: theme.icon,
                              size: AppSizes.settingsIcon(context),
                            ),

                            onPressed: () {
                              controller.isOpen
                                  ? controller.close()
                                  : controller.open();
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
// End of top bar

// Home Screen Buttons Starts
Widget homeButton({
  required BuildContext context,
  required String text,
  required IconData icon,
  required VoidCallback onPressed,
  required double size,
  

  }) {
  final theme = context.watch<ThemeManager>().currentTheme;
  return SizedBox(
    width: size,
    height: size,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        overlayColor: theme.icon,
        backgroundColor: theme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: size * 0.25, color: theme.icon),
          SizedBox(height: size * 0.06),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.icon,
              fontSize: AppTextSizes.caption(context),
            ),
          ),
        ],
      ),
    ),
  );
}
// Home Screen Button Ends

// Plan Display card start
Widget planDisplayCard({
  required BuildContext context,
  //required cardType enum,
  //required List data  // Could change from list to map etc

  }) {
    // Styling
    final theme = context.watch<ThemeManager>().currentTheme;

    return Container(
      color: theme.primary,

      child: Row(
        children: [
          // Left Character PFP/House PFP
          SizedBox(
            width: 100, // NEEDS TO BE REACTIVE
            child: IconButton(
              iconSize: 80, // NEEDS TO BE REACTIVE
              icon: const Icon(Icons.add_photo_alternate),  // PLACEHOLDER
              onPressed: () {},
            ),
          ),

          //const SizedBox(width: 16),

          // Middle - Character Stats or House Units
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Black Eagles - TEMP",          // Use values pulled from a list provided to the planDisplayCard
                  style: TextStyle(
                    fontSize: 24,                 // USE APPSIZES
                    fontWeight: FontWeight.bold,  // USE APPSIZES
                    //backgroundColor: theme.text,
                  ),
                ),

                const SizedBox(height: 8),

                const Text("• Edelgard"),
                const Text("• Hubert"),
                const Text("• Ferdinand"),
                const Text("• Bernadetta"),
              ],
            ),
          ),

          //const SizedBox(width: 16),

          // Right - Edit, Export, and delete buttons
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: "Edit",
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.import_export),
                tooltip: "Export",
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: "Delete",
                onPressed: () {},
              ),
            ],
          )
        ]
      )
    );
  }
// Plan Display Card End