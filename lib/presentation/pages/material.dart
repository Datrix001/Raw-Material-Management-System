import 'package:flutter/material.dart';
import 'package:rmms/data/datasources/gsheet.dart';
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

  bool isSyncing = false;
  String syncStatus = "";

  Future<void> syncData() async {
    setState(() {
      isSyncing = true;
      syncStatus = "Syncing...";
    });

    try {
      await Gsheet().syncToGoogleSheets();
      setState(() {
        isSyncing = false;
        syncStatus = "✅ Synced successfully!";
      });
    } catch (e) {
      setState(() {
        isSyncing = false;
        syncStatus = "❌ Sync failed: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  // final TextEditingController productName = TextEditingController();
  //   int value = 0;
  
  

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ProductDropdown(label: "Select Product", onchanged: (_){}),
                  SizedBox(height: 20,),
                  CustomDropdown(label: "Select Amount", onchanged: (_){}),
                  SizedBox(height: 10,),
                  CustomButton(function: (){}, name: "Save", color: Colors.green),
                  SizedBox(height: 10,),
                  isSyncing
                      ? const CircularProgressIndicator()
                      : CustomButton(function: syncData, name: "Refresh", color: Colors.lightBlue),
                  const SizedBox(height: 5),
                  Text(syncStatus, style: CustomFonts.body1Black),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),

          Align(
            alignment: Alignment.topLeft,
            child: Text("Manufacturing Log",style: CustomFonts.title1,))
          // Expanded(
          //   child: BlocBuilder<CompCubit, List<HiveModel>>(
          //     builder: (context, state) {
          //       return state.isEmpty
          //           ? Center(child: Text("No Data Availabe", style: CustomFonts.title))
          //           : ListView.builder(
          //         itemCount: state.length,
          //         itemBuilder: (context, index) {
          //           final item = state[index];
          //           return Container(
          //             height: 100,
          //             decoration: BoxDecoration(
          //               color: Colors.blue,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: const [BoxShadow(color: Colors.black12)],
          //             ),
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(item.productName, style: CustomFonts.body1Black),
          //                   // Spacer(),
          //                   CustomIcon(
          //                     onPressed: () {},
          //                     icon: Icon(Icons.add),
          //                     // color: Colors.white,
          //                     backgroundColor: Colors.green,
          //                   ),
          //                   Text("0", style: CustomFonts.body1Black),
          //                   CustomIcon(
          //                     onPressed: () {},
          //                     icon: Icon(Icons.remove),
          //                     // color: Colors.white,
          //                     backgroundColor: Colors.green,
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
