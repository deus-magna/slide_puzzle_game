import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/app/app.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';
import 'package:slide_puzzle_game/presentation/widgets/game_view_background.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const GameViewBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Header(),
                  const SizedBox(height: 10),
                  PuzzleBoard(),
                  Menu(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SpaceContainer(label: 'TIMER', value: '00:02:30'),
        SizedBox(width: 20),
        SpaceContainer(
          label: 'MOVES',
          value: '25',
        ),
      ],
    );
  }
}

class SpaceContainer extends StatelessWidget {
  const SpaceContainer({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: spaceContainerDecoration,
        child: Column(
          children: [
            Text(label, style: TextStyle(color: Colors.white)),
            Text(value, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class PuzzleBoard extends StatefulWidget {
  PuzzleBoard({Key? key}) : super(key: key);

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  final numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  final random = [0, 2, 3, 1, 7, 8, 6, 4, 5];

  @override
  Widget build(BuildContext context) {
    final tiles = numbers
        .map((number) =>
            Tile(source: '', validPosition: number, currentPosition: number))
        .toList();
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: spaceContainerDecoration,
      height: height * 0.50,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return numbers[index] != 0
                ? BoardTile(
                    tile: tiles[index],
                    onPressed: () => clickGrid(index),
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void clickGrid(int index) {
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 3 != 0 ||
        index + 1 < 9 && numbers[index + 1] == 0 && (index + 1) % 3 != 0 ||
        (index - 3 >= 0 && numbers[index - 3] == 0) ||
        (index + 3 < 9 && numbers[index + 3] == 0)) {
      setState(() {
        // move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    // checkWin();
  }
}

class BoardTile extends StatelessWidget {
  const BoardTile({Key? key, required this.tile, this.onPressed})
      : super(key: key);

  final Tile tile;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.amber,
          boxShadow: const [BoxShadow(offset: Offset(0, 10))],
        ),
        child: Center(
          child: Text('${tile.currentPosition}'),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container());
  }
}
