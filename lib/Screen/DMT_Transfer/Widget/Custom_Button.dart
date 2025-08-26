import 'package:flutter/material.dart';

class DmtCustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final Color? buttonColor;
  final Color? textColor;

  const DmtCustomButton({
    super.key,
     this.onPressed,
    required this.label,
    this.icon,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      backgroundColor: buttonColor ?? Colors.blue[400],
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );

    if (icon != null) {
      return ElevatedButton.icon(
        icon: Icon(icon, color: textColor ?? Colors.white),
        label: Text(
          label,
          style: TextStyle(color: textColor ?? Colors.white,),
        ),
        onPressed: onPressed,
        style: style,
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(
          label,
          style: TextStyle(color: textColor ?? Colors.white,fontSize: 18),
        ),
      );
    }
  }
}
