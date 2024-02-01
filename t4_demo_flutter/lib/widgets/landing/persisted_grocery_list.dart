import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/widgets/grocery_item.dart';

import '../../constants/strings.dart';
import '../../constants/text_styles.dart';
import '../../providers/saved_data_provider.dart';

class PersistedGroceryList extends ConsumerStatefulWidget{
  @override
  PersistedGroceryListState createState()=> PersistedGroceryListState();
}

class PersistedGroceryListState extends ConsumerState<PersistedGroceryList> {

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        getSubheading(),
      ]
    );
  }

  getSubheading() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: const Text(
        Strings.persistedGroceryTitle,
        style: TextStyles.subheadingStyle,
      ),

    );
  }

  getPersistedGroceries() {
    final savedGroceries = ref.watch(savedGroceriesProvider);
    return switch(savedGroceries) {
      AsyncData(:final value) => ListView.builder(
          itemBuilder: (context, index) {
            return GroceryItem();
          }
      ),
    AsyncError(:final error) => Text(error.toString()),
    _ => const CircularProgressIndicator(),
    };

  }

}