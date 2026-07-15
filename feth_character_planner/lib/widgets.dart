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
class PlanDisplayCard extends StatefulWidget {
  const PlanDisplayCard({super.key});

  @override
  State<PlanDisplayCard> createState() => _PlanDisplayCardState();
}

  class _PlanDisplayCardState extends State<PlanDisplayCard> {
    bool hovered = false;
    final ScrollController _scrollController = ScrollController();

    @override
    void dispose() {
      _scrollController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      final theme = context.watch<ThemeManager>().currentTheme;
      final members = [ // Will need to be taken from the JSON file
        "Edelgard",
        "Hubert",
        "Ferdinand",
        "Bernadetta",
        "Dorothea",
        "Caspar",
        "Petra",
        "Linhardt",
        "bas",
        "dih",
        "patches",
        "help",
        "me",
        "shamir",
        "name15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21"
      ];

      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hovered = true),
        onExit: (_) => setState(() => hovered = false),

        child: LayoutBuilder( 
          builder: (context, constraints) {
            // Columns for card names
            //const columns = 4;
            // Columns for card stats

            // Card width based on screen dimensions
            final cardWidth = MediaQuery.of(context).size.width * 0.80;
            final cardHeight = MediaQuery.of(context).size.height * 0.20; // 20%
            // Sizing based on card width
            //final imageWidth = cardWidth * 0.10;
            //final buttonWidth = cardWidth * 0.10;
            final imageSize = cardWidth * 0.08;
            final iconSize = imageSize * 0.33; // Same as image but seperated into 3 parts

            // Will be filled using data that is read from single JSON file
            return AnimatedContainer(
              // Style
              height: cardHeight,
              // Hover effects
              duration: const Duration(milliseconds: 150),
              transform: Matrix4.translationValues(0, hovered ? -6 : 0, 0), // Lift above ovther cards
              decoration: BoxDecoration(
                color: theme.primary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: hovered ? theme.icon : Colors.transparent,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: hovered ? 0.30 : 0.12),
                    blurRadius: hovered ? 24 : 8,
                    spreadRadius: hovered ? 2 : 0,
                    offset: Offset(0, hovered ? 10 : 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Left Character PFP/House PFP
                  Expanded(
                    flex: 1, // NEEDS TO BE REACTIVE
                    child: IconButton(
                      iconSize: imageSize, // NEEDS TO BE REACTIVE
                      icon: const Icon(Icons.add_photo_alternate),  // PLACEHOLDER
                      onPressed: () {},
                    ),
                  ),

                  //const SizedBox(width: 16),

                  // Middle - Character Stats or House Units
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // If plan is a house plan
                      children: [
                        Text(
                          "Black Eagles",
                          style: TextStyle(
                            fontSize: AppTextSizes.heading(context),
                            fontWeight: FontWeight.bold,
                            color: theme.surface,
                            height: 1.0, // Shorten to make more room for Scrollbar content
                          ),
                        ),

                        //const SizedBox(height: 12),

                        Expanded(
                          child: Scrollbar(
                            controller: _scrollController,
                            //thumbVisibility: true,
                            child: GridView.builder(
                              controller: _scrollController,
                              itemCount: members.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 6,  // Try 8, 6 and more on all screen types
                              ),
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Text(
                                    members[index],
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                      // If plan is a individual character plan
                    ),
                  ),

                  //const SizedBox(width: 16),

                  // Right - Edit, Export, and delete buttons
                  Expanded( 
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: theme.icon,
                          iconSize: iconSize,
                          tooltip: "Edit",
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.import_export),
                          color: theme.icon,
                          iconSize: iconSize,
                          tooltip: "Export",
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: theme.icon,
                          iconSize: iconSize,
                          tooltip: "Delete",
                          onPressed: () {},
                        ),
                      ],
                    )
                  )
                ]
              )
            );
          }
        )
      );
    }
  }
// Plan Display Card End