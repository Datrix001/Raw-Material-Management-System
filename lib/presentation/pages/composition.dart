import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rmms/data/models/hive_model.dart';
import 'package:rmms/presentation/bloc/comp_cubit.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class Composition extends StatelessWidget {
  const Composition({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<CompCubit, List<HiveModel>>(
      builder: (context, state) {
        return state.isEmpty ?
          Center(
            child: Text("No Data Availabe",style: CustomFonts.title,),
          ):
          ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            final item = state[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                      onPressed: (_) {
                        (context).read<CompCubit>().deleteComposition(item.id);
                      },
                      icon: Icons.delete,
                    ),
                  ],
                ),
                child: Container(
                  height: 200,
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
                            Text(item.productName, style: CustomFonts.body1),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Iron :", style: CustomFonts.body),
                            SizedBox(width: 140),
                            Text(
                              item.material1.toString(),
                              style: CustomFonts.body1,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text("Copper :", style: CustomFonts.body),
                            SizedBox(width: 140),
                            Text(
                              item.material2.toString(),
                              style: CustomFonts.body1,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text("Steel:", style: CustomFonts.body),
                            SizedBox(width: 140),
                            Text(
                              item.material3.toString(),
                              style: CustomFonts.body1,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text("Plastic :", style: CustomFonts.body),
                            SizedBox(width: 140),
                            Text(
                              item.material4.toString(),
                              style: CustomFonts.body1,
                            ),
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
      },
    );
  }
}
