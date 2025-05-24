import 'package:flutter/material.dart';
import 'package:rmms/presentation/components/dialog_box.dart';
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
  final List<String> titles = ["Raw Composition Layer", "Manufacturing"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex], style: CustomFonts.title),
      ),
      floatingActionButton: currentIndex != 0
          ? null
          : FloatingActionButton(
              onPressed: () {
                if (currentIndex == 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogBox();
                    },
                  );
                } else {}
              },
              child: currentIndex == 0 ? Icon(Icons.add) : Icon(Icons.check),
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
