import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class Composition extends StatelessWidget {
  const Composition({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Slidable(
            startActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (context) {},
                  icon: Icons.edit,
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.red,
                  onPressed: (context) {},
                  icon: Icons.delete,
                ),
              ],
            ),
            child: Container(
              height: 100,
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Colors.black12)],
              ),
              // margin: const EdgeInsets.only(bottom: 20),
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Product Name :", style: CustomFonts.body),
                        Spacer(),
                        Text("IPhone", style: CustomFonts.body1),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Steel :", style: CustomFonts.body),
                        SizedBox(width: 140),
                        Text("dfhfhcfhhcgxhfxg", style: CustomFonts.body1),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                      children: [
                        Text("Product Name :", style: CustomFonts.body),
                        SizedBox(width: 140),
                        Text("IPhone", style: CustomFonts.body1),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
