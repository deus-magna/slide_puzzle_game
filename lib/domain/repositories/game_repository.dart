abstract class GameRepository {
  bool isSolved(String key);
  Future<void> setSolved(String key);
}
