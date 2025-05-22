import 'package:flutter/material.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class Composition extends StatelessWidget {
  const Composition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Raw Composition Layer",style: CustomFonts.title,),
      ),
    );
  }
}