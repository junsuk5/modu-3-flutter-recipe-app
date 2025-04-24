import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/domain/repository/bookmark_repository.dart';
import 'package:recipe_app/domain/repository/recipe_repository.dart';
import 'package:recipe_app/presentation/home/home_action.dart';
import 'package:recipe_app/presentation/home/home_state.dart';
import 'package:recipe_app/utils/errors/recipe_error_enum.dart';
import 'package:recipe_app/utils/result/result.dart';

import '../../domain/use_case/get_saved_recipes_stream_use_case.dart';

class HomeViewModel with ChangeNotifier {
  final RecipeRepository _repository;
  final BookmarkRepository _bookmarkRepository;

  final GetSavedRecipesStreamUseCase _getSavedRecipesStreamUseCase;

  StreamSubscription? _subscription;

  HomeState _state = const HomeState();

  HomeViewModel(
    this._repository,
    this._bookmarkRepository,
    this._getSavedRecipesStreamUseCase,
  ) {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      _bookmarkRepository.save(1);
      _bookmarkRepository.save(2);
      _bookmarkRepository.save(4);
    });
  }

  HomeState get state => _state;

  Future<void> action(HomeAction action) async {
    switch (action) {
      case OnCategoryClick():
        _findRecipesByCategory(action.category);
      case FindRecipes():
        _findRecipes();
      case OnBookmarkClick():
        _bookmarkRepository.save(action.recipeId);
      case OnSearchTap():
        break;
    }

    _state = state.copyWith(
      bookmarkIds: await _bookmarkRepository.getBookmarkIds(),
    );

    notifyListeners();
  }

  Future<void> _findRecipes() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _subscription = _getSavedRecipesStreamUseCase.execute().listen((result) {
      switch (result) {
        case Success<List<Recipe>, RecipeErrorEnum>():
          _state = state.copyWith(recipes: result.success, isLoading: false);
          notifyListeners();
        case Error<List<Recipe>, RecipeErrorEnum>():
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    });
  }

  Future<void> _findRecipesByCategory(String category) async {
    _state = state.copyWith(isLoading: true);
    _state = state.copyWith(selectedCategory: category);
    notifyListeners();

    final result = await _repository.findRecipeByCategory(category);

    switch (result) {
      case Success<List<Recipe>, RecipeErrorEnum>():
        _state = state.copyWith(isLoading: false, recipes: result.success);
        notifyListeners();
      case Error<List<Recipe>, RecipeErrorEnum>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
