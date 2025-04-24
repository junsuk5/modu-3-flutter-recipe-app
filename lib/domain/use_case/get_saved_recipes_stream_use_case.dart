import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/domain/repository/bookmark_repository.dart';
import 'package:recipe_app/domain/repository/recipe_repository.dart';
import 'package:recipe_app/utils/errors/recipe_error_enum.dart';
import 'package:recipe_app/utils/result/result.dart';

class GetSavedRecipesStreamUseCase {
  final BookmarkRepository _bookmarkRepository;
  final RecipeRepository _recipeRepository;

  const GetSavedRecipesStreamUseCase(
    this._bookmarkRepository,
    this._recipeRepository,
  );

  BookmarkRepository get bookmarkRepository => _bookmarkRepository;

  Stream<Result<List<Recipe>, RecipeErrorEnum>> execute() async* {
    try {
      // 북마크 ID 스트림을 구독
      await for (final ids in _bookmarkRepository.getBookmarkIdsStream()) {
        try {
          // 북마크 ID가 변경될 때마다 레시피 데이터를 새로 가져옴
          final result = await _recipeRepository.findDatas();

          switch (result) {
            case Success<List<Recipe>, RecipeErrorEnum>():
            // 북마크된 레시피만 필터링하여 반환
              yield Result.success(
                result.success.where((recipe) => ids.contains(recipe.id)).toList(),
              );
            case Error<List<Recipe>, RecipeErrorEnum>():
              yield const Result.error(RecipeErrorEnum.networkerror);
          }
        } catch (e) {
          yield const Result.error(RecipeErrorEnum.networkerror);
        }
      }
    } on RecipeErrorEnum {
      yield const Result.error(RecipeErrorEnum.networkerror);
    } catch (e) {
      yield const Result.error(RecipeErrorEnum.networkerror);
    }
  }
}
