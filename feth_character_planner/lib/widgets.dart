import 'package:flutter/material.dart';
import 'package:feth_character_planner/themes.dart';

// Topbar class
class MyTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Current page name
  // List containing pages that will confirm that the user wishes to go to homepage - Used on editing pages (create character, create house, etc...)
  final confirmMsgPages = [
    "none",
    "noneTwo"
    // USED AS SUCH: EditPage1.routeName, EditPage2.routeName...
  ];

  MyTopBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeManager>().currentTheme;
    return SafeArea(
      child: Container(
        color: theme.background,
        height: 56,
        child: Row(
          children: [
            // Left - Home button/icon
            Expanded(
              flex: 1,
              child: HoverIconButton(
                icon: Image.asset(
                  "assets/images/crest_of_flames.png",
                  width: 36,
                  height: 36,
                ),
                onPressed: () {
                  // Takes you to the homepage when pressed
                  // Depending on the page you are on, it will ask for confirmation (used for editing pages etc)
                  
                },
              )
              ),

            // Middle - Title section
            Expanded(
              flex: 8,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),

            // Right - Settings
            Expanded(
              flex: 1,
              child: HoverIconButton(
                icon: Icon(
                  Icons.settings,
                  size: 36,
                  color: theme.accent,
                ),
                onPressed: () {
                  debugPrint("Settings button pressed, accent color: ${theme.accent}");
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
// End of top bar

// HoverIconButton class start 
// Special Hovering icon button for top bar icons
class HoverIconButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final double size;

  const HoverIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 32,
  });

  @override
  State<HoverIconButton> createState() => _HoverIconButtonState();
}
// HoverIconButton class end 

// HoverIconButtonState class start 
// Manages the state of the hovered button
class _HoverIconButtonState extends State<HoverIconButton> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double iconSize;

    if (screenWidth < 600) {
      iconSize = 32; // Phone
    } else if (screenWidth < 1200) {
      iconSize = 40; // Tablet
    } else {
      iconSize = 44; // Desktop/Web
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: hovering
              ? Colors.black.withValues(alpha: 0.33)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          constraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
          padding: EdgeInsets.zero,
          icon: SizedBox(
            width: iconSize,
            height: iconSize,
            child: widget.icon,
          ),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
// HoverIconButtonState class end 