import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {

  final VoidCallback onPressed;
  final Icon icon;
  final Color backgroundColor;
  final Color color;
  const CustomIcon({super.key, required this.onPressed, required this.icon, required this.color, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor
      ),
      child: IconButton(
        color: color,
        onPressed: onPressed, icon: icon),
    );
  }
}