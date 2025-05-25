import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmms/data/datasources/gsheet.dart';
import 'package:rmms/data/models/hive_model.dart';
import 'package:rmms/domain/logic_method.dart';
import 'package:rmms/presentation/bloc/inventory_cubit.dart';
import 'package:rmms/presentation/components/custom_button.dart';
import 'package:rmms/presentation/components/dropdown.dart';
import 'package:rmms/presentation/components/product_dropdown.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class MaterialLayer extends StatefulWidget {
  const MaterialLayer({super.key});

  @override
  State<MaterialLayer> createState() => _MaterialLayerState();
}

class _MaterialLayerState extends State<MaterialLayer> {
  String? selectedProduct;
  int selectedQuantity = 1;
  List<String> manufacturingLog = [];

  void _showSnackBar(String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ProductDropdown(
                    label: "Select Product",
                    onchanged: (val) {
                      setState(() {
                        selectedProduct = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDropdown(
                    label: "Select Amount",
                    onchanged: (val) {
                      final strVal = val.toString();
                      setState(() {
                        selectedQuantity = int.tryParse(strVal) ?? 1;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    function: () async {
                      if (selectedProduct == null || selectedProduct!.isEmpty) {
                        _showSnackBar("Please select a product.", Colors.red);
                        return;
                      }
                      if (selectedQuantity <= 0) {
                        _showSnackBar(
                          "Please select a valid quantity.",
                          Colors.red,
                        );
                        return;
                      }

                      final result = await InventoryService.deductInventory(
                        productName: selectedProduct!,
                        quantity: selectedQuantity,
                      );

                      _showSnackBar(result.message, result.color);

                      if (result.success) {
                        setState(() {
                          manufacturingLog.add(
                            "$selectedQuantity units of $selectedProduct manufactured",
                          );
                        });
                      }
                    },
                    name: "Save",
                    color: Colors.green,
                  ),

                  CustomButton(
                    name: "Sync Inventory from Google Sheets",
                    color: Colors.blue,
                    function: () async {
                      await Gsheet().fetchInventoryFromGoogleSheets();
                      context.read<InventoryCubit>().refresh();

                      _showSnackBar(
                        "Inventory synced from Google Sheets",
                        Colors.green,
                      );
                    },
                  ),

                  Expanded(
                    child: BlocBuilder<InventoryCubit, List<InventoryModel>>(
                      builder: (context, state) {
                        if (state.isEmpty) {
                          return Center(child: Text('No inventory data found.'));
                        }
                    
                        return ListView.builder(
                          itemCount: state.length,
                          itemBuilder: (context, index) {
                            final item = state[index];
                            return ListTile(
                              title: Text(item.material ?? 'Unknown'),
                              subtitle: Text(
                                'Quantity: ${item.quantity}, Threshold: ${item.threshold}',
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text("Manufacturing Log", style: CustomFonts.title1),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: manufacturingLog.isEmpty
                  ? const Center(child: Text("No manufacturing logs yet"))
                  : ListView.builder(
                      itemCount: manufacturingLog.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(manufacturingLog[index]));
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
