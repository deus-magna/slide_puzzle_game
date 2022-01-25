import 'package:flutter/material.dart';

class GameViewBackground extends StatelessWidget {
  const GameViewBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        SizedBox(
          width: double.infinity,
          child: Image(
            image:
                AssetImage('assets/img/backgrounds/game_view_background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
