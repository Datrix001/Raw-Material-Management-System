import 'package:flutter/material.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final int? initialValue;
  final Function(int) onchanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.onchanged, this.initialValue,
  });

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
      value: widget.initialValue ??dropDownValue,
      isExpanded: true,
      items: [
        for (int i = 1; i <= 10; i++)
          DropdownMenuItem(value: i, child: Text(i.toString())),
      ],
      onChanged: (value) {
        setState(() {
          dropDownValue = value!;
        });
        widget.onchanged(value!); // Note : It will tell the parent 
      },
    );
  }
}
