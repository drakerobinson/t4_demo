import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/services/ingredients_service.dart';
import 'package:t4_demo_flutter/widgets/components/ingredient_card.dart';
import 'package:t4_demo_flutter/widgets/grocery_item.dart';

import '../../constants/strings.dart';
import '../../constants/text_styles.dart';
import '../../dto_s/ingredients.dart';
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
        getPersistedGroceries()
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
    return Flexible(child: FutureBuilder(
        future: IngredientsService().getSavedIngredients(),
        builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
          if(snapshot.hasError) {
            return const Text("There was an issue retrieving your data");
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return IngredientCard(snapshot.data![index]);
                }
            );
          }
          return const CircularProgressIndicator();
        }
    ));

  }

}