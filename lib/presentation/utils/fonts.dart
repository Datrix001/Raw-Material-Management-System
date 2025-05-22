import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFonts {

  static TextStyle title = GoogleFonts.ubuntu(
    fontSize: 26,
    fontWeight: FontWeight.w600
  );

  static TextStyle body = GoogleFonts.ubuntu(
    fontWeight: FontWeight.w500,
    color:Colors.white
  );
  static TextStyle body1= GoogleFonts.ubuntu(
    fontWeight: FontWeight.w300,
    color:Colors.white
  );

  static TextStyle bodyBlack= GoogleFonts.ubuntu(
    fontWeight: FontWeight.w600,
    // color:Colors.white
  );
}