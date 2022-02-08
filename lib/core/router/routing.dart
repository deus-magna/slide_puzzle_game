import 'package:flutter/widgets.dart';
import 'package:slide_puzzle_game/presentation/views/difficulty_view.dart';
import 'package:slide_puzzle_game/presentation/views/game_view.dart';
import 'package:slide_puzzle_game/presentation/views/home_view.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/home': (BuildContext context) => const HomeView(),
    '/difficult': (BuildContext context) => const DifficultyView(),
    // '/game': (BuildContext context) => const GameView(),
  };
}
