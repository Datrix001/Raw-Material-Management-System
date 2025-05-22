import 'package:flutter/material.dart';

class MaterialLayer extends StatelessWidget {
  const MaterialLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set a background if needed
      alignment: Alignment.center, // Align content to center
      child: Text(
        "HI",
        style: TextStyle(fontSize: 24, color: Colors.black), // Visible text
      ),
    );
  }
}