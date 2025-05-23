import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmms/presentation/bloc/comp_cubit.dart';
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
  int iron = 1;
  int copper = 1;
  int steel = 1;
  int plastic = 1;
  
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

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

              CustomDropdown(
                label: "Select Amount For Iron",
                onchanged: (val) => setState(() => iron = val),
              ),
              SizedBox(height: 10),
              CustomDropdown(
                label: "Select Amount For Copper",
                onchanged: (val) => setState(() => copper = val),
              ),
              SizedBox(height: 10),

              CustomDropdown(
                label: "Select Amount For Steel",
                onchanged: (val) => setState(() => steel = val),
              ),
              SizedBox(height: 10),

              CustomDropdown(
                label: "Select Amount For Plastic",
                onchanged: (val) => setState(() => plastic = val),
              ),
            ],
          ),
        ),
      ),
      actions: [
        CustomButton(
          function: () async {
            final random = Random().nextInt(10000);

            Map<String, dynamic> productDetail = {
              "id": random.toString(),
              "productName": nameController.text,
              "material1": iron,
              "material2": copper,
              "material3": steel,
              "material4": plastic,
            };
            context.read<CompCubit>().addComposition(productDetail);
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
