import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final VoidCallback? onBackPress;
  final VoidCallback? onNotificationPress;

  const CustomAppBar({
    Key? key,
    required this.titleText,
    this.onBackPress,
    this.onNotificationPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffFFFFFF), // top color
              Color(
                0xffFFFFFF,
              ), // bottom color (same white for solid white look)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Center(
        child: SizedBox(
          child: Image.asset(
            'lib/assets/images/logs.png',
            height: 250,
            width: 250,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
