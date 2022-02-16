import 'package:shared_preferences/shared_preferences.dart';

abstract class GameLocalDatasource {
  bool isSolved(String key);
  Future<void> setSolved(String key);
}

class GameLocalDatasourceImpl extends GameLocalDatasource {
  GameLocalDatasourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  @override
  bool isSolved(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  @override
  Future<void> setSolved(String key) async {
    await sharedPreferences.setBool(key, true);
  }
}
