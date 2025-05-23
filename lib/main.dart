import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmms/data/datasources/hive_data.dart';
// import 'package:rmms/data/google_sheets_api.dart';
import 'package:rmms/data/models/hive_model.dart';
import 'package:rmms/presentation/pages/composition.dart';
import 'package:rmms/presentation/pages/home.dart';
import 'package:rmms/presentation/pages/material.dart';
import 'package:rmms/presentation/utils/theme.dart';

void main() async{
  //initialise spreadsheet
  WidgetsFlutterBinding.ensureInitialized();
  // await GoogleSheetsApi.init();
  await HiveData.init();
  Hive.registerAdapter(HiveModelAdapter());
  await Hive.openBox<HiveModel>("composition");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: MyTheme.darkTheme,
      theme: MyTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/composition": (context) => Composition(),
        "/material": (context) => MaterialLayer(),
      },
    );
  }
}
