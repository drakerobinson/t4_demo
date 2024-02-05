import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/widgets/landing/persisted_grocery_list.dart';
import 'package:t4_demo_flutter/widgets/landing/persisted_recipes.dart';

import '../../constants/colors.dart';

class MultiTab extends StatefulWidget {
  @override
  MultiTabState createState()=> MultiTabState();
}

class MultiTabState extends State<MultiTab> {

  bool isSavedGroceries = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Center(child: getTabButtons()),
           Flexible(child: isSavedGroceries ? PersistedGroceryList(): PersistedRecipes()),
    ],)));
  }

  getTabButtons() {
    return SizedBox(
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isSavedGroceries = true;
                });
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  color: isSavedGroceries ? AppColors.darkPrimary: Colors.grey,
                ),
                child: const Text("Saved Groceries", textAlign: TextAlign.center,),
              ),
            ),
            const SizedBox(width: 10,),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSavedGroceries = false;
                });
              },
              child: Container(

                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: !isSavedGroceries ? AppColors.darkPrimary: Colors.grey,
                ),
                child: const Text("Saved Recipes", textAlign: TextAlign.center,),
              )
            ),

        ],));
  }

}