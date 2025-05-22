import 'package:flutter/material.dart';
import 'package:rmms/presentation/pages/composition.dart';
import 'package:rmms/presentation/pages/material.dart';
import 'package:rmms/presentation/utils/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: MyTheme.darkTheme,
      theme: MyTheme.lightTheme,
      initialRoute: "/",
      routes: {
        "/" : (context) => Composition(),
        "/material" : (context) => MaterialLayer()
      },
    );
  }
}
