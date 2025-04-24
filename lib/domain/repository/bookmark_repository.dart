abstract interface class BookmarkRepository {
  Future<void> clear();
  Future<List<int>> getBookmarkIds();
  Stream<List<int>> getBookmarkIdsStream();
  Future<void> save(int id);
  Future<void> toggle(int id);
  Future<void> unSave(int id);
}
