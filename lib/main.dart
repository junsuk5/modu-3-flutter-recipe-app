import 'package:flutter/material.dart';
import 'package:recipe_app/core/presentation/components/component_test_screen.dart';
import 'package:recipe_app/data/data_source/recipe_data_source_impl.dart';
import 'package:recipe_app/data/repository/recipe_repository_impl.dart';
import 'package:recipe_app/presentation/saved_recipes/saved_recipes_view_model.dart';
import 'package:recipe_app/presentation/saved_recipes/screen/saved_recipes_root.dart';
import 'package:recipe_app/ui/color_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorStyle.primary60),
      ),
      home: const Scaffold(body: NewWidget()),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ComponentTestScreen(),
                ),
              );
            },
            child: const Text('Components'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => SavedRecipeRoot(
                        viewModel: SavedRecipesViewModel(
                          RecipeRepositoryImpl(RecipeDataSourceImpl()),
                        ),
                      ),
                ),
              );
            },
            child: const Text('Saved Recipes'),
          ),
        ],
      ),
    );
  }
}
