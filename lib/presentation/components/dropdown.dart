import 'package:flutter/material.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  const CustomDropdown({super.key, required this.label});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  int? dropDownValue = 1;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        label: Text(widget.label, style: CustomFonts.bodyBlack),
        border: OutlineInputBorder(),
      ),
      // value: dropDownValue,
      isExpanded: true,
      // hint: Text("Material 1"),
      items: [
        for (int i = 1; i <= 10; i++)
          DropdownMenuItem(value: i, child: Text(i.toString())),
      ],
      onChanged: (value) => {
        setState(() {
          dropDownValue = value!;
        }),
      },
    );
  }
}
