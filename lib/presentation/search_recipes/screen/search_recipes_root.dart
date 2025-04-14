import 'package:flutter/material.dart';
import 'package:recipe_app/core/presentation/components/filter_search_bottom_sheet.dart';
import 'package:recipe_app/presentation/search_recipes/screen/search_recipes_screen.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_view_model.dart';

class SearchRecipeRoot extends StatelessWidget {
  final SearchRecipesViewModel viewModel;
  final TextEditingController controller;

  const SearchRecipeRoot({
    super.key,
    required this.viewModel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      builder: (BuildContext context, Widget? child) {
        return SearchRecipesSreen(
          controller: controller,
          onChange: (value) {
            viewModel.search(value);
          },
          onSettingsClick: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return FilterSearchBottomSheet(
                  state: viewModel.state.filtetState,
                  onfilterClick: (filterState) {
                    viewModel.searchFilter(filterState);
                  },
                  onCancelClick: (filterState) {
                    viewModel.findRecipes();
                  },
                );
              },
            );
          },
          state: viewModel.state,
        );
      },
      listenable: viewModel..findRecipes(),
    );
  }
}
