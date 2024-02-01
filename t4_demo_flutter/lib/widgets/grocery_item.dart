import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroceryItem extends StatefulWidget {
  @override
  GroceryItemState createState()=> GroceryItemState();
}

class GroceryItemState extends State<GroceryItem> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: const Text("A Grocery Item"),
    );
  }

}