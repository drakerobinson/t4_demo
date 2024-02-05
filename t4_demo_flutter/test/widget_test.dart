
import 'package:flutter_test/flutter_test.dart';
import 'package:t4_demo_flutter/constants/strings.dart';
import 'package:t4_demo_flutter/dto_s/ingredients.dart';
import 'package:t4_demo_flutter/dto_s/recipe.dart';
import 'package:t4_demo_flutter/widgets/landing/multi_tab.dart';

void main() {
  testWidgets('Landing has Grocery and Recipes tabs', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MultiTab());

    //test that tabs are rendered
    expect(find.text(Strings.savedGroceries), findsOneWidget);
    expect(find.text( Strings.savedRecipes), findsOneWidget);

    await tester.pump();

  });


  group("Test Recipe JSON conversions", () {

    Map<String, dynamic> mockSON = {
      'image': 'https://picsum.photos/200/300',
      'sourceUrl': '',
      'title': 'Test Recipe',
      'extendedIngredients': [
        {
          'id': 1,
          'nameClean': 'testName',
          'amount': 2.0,
          'unit': 'OZ',
        },
      ]
    };

    Recipe expectedRecipe = Recipe(
        imageUrl: 'https://picsum.photos/200/300',
        sourceUrl: '',
        recipeName: 'Test Recipe',
        ingredients: [
          Ingredient(
              id: 1,
              name: 'testName',
              quantity: 2.0,
              metric: 'OZ')
        ]
    );
    
    test("Test toJSON on Recipes", () {
      expect(Recipe.fromJSON(mockSON), expectedRecipe);
    });

    test("Ingredients correctly serialized", () {
      expect(Ingredient.fromExpandedJSON(mockSON['extendedIngredients'].first), expectedRecipe.ingredients.first);
    });
    
  });


  
}


