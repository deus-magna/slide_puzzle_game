abstract class GameRepository {
  bool isSolved(String key);
  Future<void> setSolved(String key);
  List<int> getBestResults(String key);
  Future<void> setBestResults(String key, List<int> values);
}
