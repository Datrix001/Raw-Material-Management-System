import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmms/data/models/hive_model.dart';
import 'package:rmms/presentation/bloc/comp_cubit.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class ProductDropdown extends StatefulWidget {
  final String label;
  final Function(String) onchanged;
  const ProductDropdown({
    super.key,
    required this.label,
    required this.onchanged,
  });

  @override
  State<ProductDropdown> createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  String? dropDownValue;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompCubit,List<HiveModel>>(
      builder: (context, state) {
        if(state.isEmpty){
          return Text("No Product availabel");
        }
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            label: Text(widget.label, style: CustomFonts.bodyBlack),
            border: OutlineInputBorder(),
          ),
          value: dropDownValue,
          isExpanded: true,
          items: state.map((item){
            return DropdownMenuItem<String>(
              value: item.productName,
              child: Text(item.productName));
          }).toList(),
          onChanged: (value) {
            setState(() {
              dropDownValue = value!;
            });
            widget.onchanged(value!); // Note : It will tell the parent
          },
        );
      },
    );
  }
}
