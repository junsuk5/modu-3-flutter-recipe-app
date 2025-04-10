import 'package:flutter/material.dart';
import 'package:recipe_app/core/presentation/components/big_button.dart';
import 'package:recipe_app/core/presentation/components/ingredient_item.dart';
import 'package:recipe_app/core/presentation/components/input_field.dart';
import 'package:recipe_app/core/presentation/components/medium_button.dart';
import 'package:recipe_app/core/presentation/components/multi_tabs.dart';
import 'package:recipe_app/core/presentation/components/recipe_card.dart';
import 'package:recipe_app/core/presentation/components/small_button.dart';
import 'package:recipe_app/data/model/recipe.dart';

class ComponentTestScreen extends StatefulWidget {
  const ComponentTestScreen({super.key});

  @override
  _ComponentTestScreenState createState() => _ComponentTestScreenState();
}

class _ComponentTestScreenState extends State<ComponentTestScreen> {
  int tabSelectedValue = 0;
  final Recipe recipe = Recipe(
    foodName: 'Traditional spare ribs baked',
    chef: 'Chef John',
    time: 20,
    rate: 4.0,
    image: 'assets/images/food.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigButton(text: 'Big', onClick: () {}),
            MediumButton(text: 'medium', onClick: () {}),
            SmallButton(text: 'small', onClick: () {}),
            InputField(
              label: 'Label',
              value: 'value',
              placeHolder: 'place_holder',
              onValueChange: (value) {
                print(value);
              },
            ),
            MultiTabs(
              labels: ['Label1', 'Label2'],
              selectedIndex: tabSelectedValue,
              onValueChange: (value) {
                setState(() {
                  tabSelectedValue = value;
                });
              },
            ),
            IngredientItem(
              ingredientName: 'Tomaots',
              imageName: 'assets/images/tomato.png',
              amount: '500g',
            ),
            RecipeCard(recipe: recipe, onBookmarkClick: () {}),
          ],
        ),
      ),
    );
  }
}
