import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:slide_puzzle_game/presentation/views/game/animated_game_view_background.dart';

class GameViewBackground extends StatelessWidget {
  const GameViewBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => AnimatedGameViewBackground.mobile(),
      tablet: (BuildContext context) => AnimatedGameViewBackground.desktop(),
      desktop: (BuildContext context) => AnimatedGameViewBackground.desktop(),
    );
  }
}
