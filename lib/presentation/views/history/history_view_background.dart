import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:slide_puzzle_game/presentation/views/history/animated_history_view_background.dart';

class HistoryViewBackground extends StatelessWidget {
  const HistoryViewBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => AnimatedHistoryViewBackground.mobile(),
      tablet: (BuildContext context) => AnimatedHistoryViewBackground.desktop(),
      desktop: (BuildContext context) =>
          AnimatedHistoryViewBackground.desktop(),
    );
  }
}
