import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rmms/data/datasources/hive_data.dart';
import 'package:rmms/domain/business%20logic/timer.dart';
import 'package:rmms/presentation/bloc/comp_cubit.dart';
import 'package:rmms/presentation/pages/composition.dart';
import 'package:rmms/presentation/pages/home.dart';
import 'package:rmms/presentation/pages/material.dart';
import 'package:rmms/presentation/utils/theme.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveData.init();
  SyncService.startSyncing(interval: Duration(minutes: 1));
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompCubit(),
      child: MaterialApp(
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
      ),
    );
  }
}
