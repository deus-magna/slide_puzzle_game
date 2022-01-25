import 'package:flutter/widgets.dart';
import 'package:slide_puzzle_game/presentation/views/difficulty_view.dart';
import 'package:slide_puzzle_game/presentation/views/game_view.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/game': (BuildContext context) => const GameView(),
    '/difficult': (BuildContext context) => const DifficultyView(),
  };
}
