import 'package:flutter/material.dart';
import 'package:rmms/presentation/pages/composition.dart';
import 'package:rmms/presentation/pages/material.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  void indexChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> pages = [Composition(), MaterialLayer()];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Raw Composition Layer", style: CustomFonts.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: indexChange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Composition"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Material"),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
