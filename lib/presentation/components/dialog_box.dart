import 'package:flutter/material.dart';
import 'package:rmms/presentation/components/custom_button.dart';
import 'package:rmms/presentation/components/dropdown.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final TextEditingController nameController = TextEditingController();
  var dropDownValue = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Product", style: CustomFonts.title),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  label: Text("Product Name", style: CustomFonts.bodyBlack),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              CustomDropdown(label: "Select Amount For Iron"),
              SizedBox(height: 10),
              CustomDropdown(label: "Select Amount For Copper"),
              SizedBox(height: 10),
              CustomDropdown(label: "Select Amount For Steel"),
              SizedBox(height: 10),
              CustomDropdown(label: "Select Amount For Plastic"),
            ],
          ),
        ),
      ),
      actions: [
        CustomButton(
          function: () {
            Navigator.pop(context);
          },
          name: "Save",
          color: Colors.green,
        ),
        CustomButton(
          function: () {
            Navigator.pop(context);
          },
          name: "Cancel",
          color: Colors.grey,
        ),
      ],
    );
  }
}
