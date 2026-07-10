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