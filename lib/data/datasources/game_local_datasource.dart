import 'package:shared_preferences/shared_preferences.dart';

abstract class GameLocalDatasource {
  bool isSolved(String key);
  Future<void> setSolved(String key);
  List<String> getBestResults(String key);
  Future<void> setBestResults(String key, List<String> values);
}

class GameLocalDatasourceImpl extends GameLocalDatasource {
  GameLocalDatasourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  @override
  bool isSolved(String key) => sharedPreferences.getBool(key) ?? false;

  @override
  Future<void> setSolved(String key) async {
    await sharedPreferences.setBool(key, true);
  }

  @override
  List<String> getBestResults(String key) =>
      sharedPreferences.getStringList(key) ?? <String>[];

  @override
  Future<void> setBestResults(String key, List<String> values) async {
    await sharedPreferences.setStringList(key, values);
  }
}
