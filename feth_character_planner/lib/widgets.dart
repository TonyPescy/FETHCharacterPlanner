import 'package:flutter/material.dart';
import 'package:feth_character_planner/themes.dart';
import 'package:provider/provider.dart';

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
              child: MenuAnchor(
                style: MenuStyle(
                  backgroundColor: WidgetStatePropertyAll(theme.surface),
                  surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
                  elevation: const WidgetStatePropertyAll(8),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                menuChildren: [
                  MenuItemButton(
                    onPressed: () {
                      debugPrint("Theme");
                    },
                    child: Text(
                      "Themes", 
                      style: TextStyle(
                        fontSize: AppTextSizes.body(context),
                        color: theme.text
                      ),
                    ),
                  ),

                  MenuItemButton(
                    onPressed: () {
                      debugPrint("Settings");
                    },
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: AppTextSizes.body(context),
                        color: theme.text
                      ),  
                    ),
                  ),

                  const Divider(height: 1),

                  MenuItemButton(
                    onPressed: () {
                      debugPrint("About");
                    },
                    child: Text(
                      "About",
                      style: TextStyle(
                        fontSize: AppTextSizes.body(context),
                        color: theme.text
                      ),
                    ),
                  ),
                ],

                builder: (context, controller, child) {
                  return SizedBox(
                    //width: height,
                    height: height,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        Icons.settings,
                        color: theme.accent,
                        size: AppSizes.settingsIcon(context)
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