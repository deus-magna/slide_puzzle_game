import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/presentation/views/difficulty_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SpaceButton(title: 'RANKING'),
            SpaceButton(title: 'HISTORY'),
            SpaceButton(title: 'CREDITS'),
          ],
        ),
      ),
    );
  }
}
