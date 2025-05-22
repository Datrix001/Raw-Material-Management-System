import 'package:flutter/material.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback function;
  final String name;
  final Color color;
  const CustomButton({super.key, required this.function, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ButtonStyle(
        // minimumSize:WidgetStateProperty.all(Size(10, 40)),
        backgroundColor: WidgetStateProperty.all(color),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
      onPressed: function,
      child: Text(name, style: CustomFonts.bodyBlack),
    );
  }
}
