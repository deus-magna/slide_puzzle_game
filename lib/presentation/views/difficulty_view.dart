import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/presentation/widgets/background_image.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          const BackgroundImage(
            backgroundImage:
                'assets/img/backgrounds/difficult_view_background.png',
          ),
          ElevatedButton(
              onPressed: () => print('selected'), child: Text('Ranking')),
        ],
      ),
    );
  }
}
