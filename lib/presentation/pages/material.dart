import 'package:flutter/material.dart';
import 'package:rmms/presentation/components/Custom_icon.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class MaterialLayer extends StatelessWidget {
  const MaterialLayer({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.black12)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product Name", style: CustomFonts.body1Black),
                  // Spacer(),
                  CustomIcon(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    // color: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  Text("1", style: CustomFonts.body1Black),
                  CustomIcon(
                    onPressed: () {},
                    icon: Icon(Icons.remove),
                    // color: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
