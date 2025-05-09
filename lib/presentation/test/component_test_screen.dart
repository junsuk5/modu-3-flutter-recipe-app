import 'package:flutter/material.dart';
import 'package:recipe_app/core/presentation/components/big_button.dart';
import 'package:recipe_app/core/presentation/components/filter_button.dart';
import 'package:recipe_app/core/presentation/components/filter_search_bottom_sheet.dart';
import 'package:recipe_app/core/presentation/components/ingredient_item.dart';
import 'package:recipe_app/core/presentation/components/input_field.dart';
import 'package:recipe_app/core/presentation/components/medium_button.dart';
import 'package:recipe_app/core/presentation/components/multi_tabs.dart';
import 'package:recipe_app/core/presentation/components/rating_button.dart';
import 'package:recipe_app/core/presentation/components/rating_dialog_drag.dart';
import 'package:recipe_app/core/presentation/components/recipe_card.dart';
import 'package:recipe_app/core/presentation/components/recipe_tile.dart';
import 'package:recipe_app/core/presentation/components/search_input.dart';
import 'package:recipe_app/core/presentation/components/small_button.dart';
import 'package:recipe_app/data/enums/category.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/presentation/search_recipes/filter_state.dart';

class ComponentTestScreen extends StatefulWidget {
  const ComponentTestScreen({super.key});

  @override
  State<ComponentTestScreen> createState() => _ComponentTestScreenState();
}

class _ComponentTestScreenState extends State<ComponentTestScreen> {
  int tabSelectedValue = 0;
  bool isRatingSelected = false;
  bool isFilterSelected = false;
  final Recipe recipe = const Recipe(
    id: 1,
    foodName: 'Traditional spare ribs baked',
    chef: 'Chef John',
    time: '20 min',
    rate: 4.0,
    image: 'assets/images/food.png',
    ingredients: [],
    category: Category.unknown,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
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
                  labels: const ['Label1', 'Label2'],
                  selectedIndex: tabSelectedValue,
                  onValueChange: (value) {
                    setState(() {
                      tabSelectedValue = value;
                    });
                  },
                ),
                const IngredientItem(
                  ingredientName: 'Tomaots',
                  imageName: 'assets/images/tomato.png',
                  amount: '500g',
                ),
                RecipeCard(
                  recipe: recipe,
                  onBookmarkClick: (value) {},
                  onCardClick: (value) {},
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isRatingSelected = !isRatingSelected;
                    });
                  },
                  child: RatingButton(text: '5', isSelected: isRatingSelected),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFilterSelected = !isFilterSelected;
                    });
                  },
                  child: FilterButton(
                    text: 'Text',
                    isSelected: isFilterSelected,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      builder: (BuildContext context) {
                        return RatingDialogDrag(
                          title: 'Rate recipe',
                          actionName: 'Send',
                          onChange: (int value) {
                            print(value);
                          },
                        );
                      },
                      context: context,
                    );
                  },
                  child: const Text('show alert'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (BuildContext context) {
                        return FilterSearchBottomSheet(
                          state: FilterState(),
                          onfilterClick: (filterState) {
                            print(filterState);
                          },
                          onCancelClick: (filterState) {
                            print('cancel');
                          },
                        );
                      },
                    );
                  },
                  child: const Text('show bottom sheet'),
                ),
                RecipeTile(recipe: recipe),
                SearchInput(
                  isMain: false,
                  onValueChange: (value) {},
                  controller: TextEditingController(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
