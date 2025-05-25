import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rmms/data/datasources/hive_data.dart';
import 'package:rmms/domain/business%20logic/timer.dart';
import 'package:rmms/presentation/bloc/comp_cubit.dart';
import 'package:rmms/presentation/bloc/inventory_cubit.dart';
import 'package:rmms/presentation/pages/composition.dart';
import 'package:rmms/presentation/pages/home.dart';
import 'package:rmms/presentation/pages/material.dart';
import 'package:rmms/presentation/utils/theme.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveData.init();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CompCubit(),),
        BlocProvider(create: (context)=>InventoryCubit())
      ],
      child: Builder(
        builder: (context) {
          SyncService.startSyncing(
            cubit: context.read<InventoryCubit>(),
            interval: Duration(minutes: 1),
          );
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
      ),
    );
  }
}
