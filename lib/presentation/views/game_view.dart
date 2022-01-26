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
                  SpaceBar(),
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

class SpaceBar extends StatelessWidget {
  const SpaceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          IconButton(
              onPressed: () => print('Pressed'),
              icon: const Icon(
                Icons.volume_off_rounded,
                color: Colors.white,
              )),
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
            Text(value, style: TextStyle(color: Colors.white, fontSize: 30)),
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

  AlignmentGeometry _alignment = Alignment.topCenter;

  List<Tile> mockTiles() {
    final tiles = <Tile>[
      Tile(
        value: 0,
        source: 'assets/img/tiles/uan/uan_0.png',
        validPosition: const Position(x: 1, y: 1),
        currentPosition: const Position(x: 1, y: 1),
      ),
      Tile(
        value: 1,
        source: 'assets/img/tiles/uan/uan_1.png',
        validPosition: const Position(x: 2, y: 1),
        currentPosition: const Position(x: 2, y: 1),
      ),
      Tile(
        value: 2,
        source: 'assets/img/tiles/uan/uan_2.png',
        validPosition: const Position(x: 3, y: 1),
        currentPosition: const Position(x: 3, y: 1),
      ),
      Tile(
        value: 3,
        source: 'assets/img/tiles/uan/uan_3.png',
        validPosition: const Position(x: 1, y: 2),
        currentPosition: const Position(x: 1, y: 2),
      ),
      Tile(
        value: 4,
        source: 'assets/img/tiles/uan/uan_4.png',
        validPosition: const Position(x: 2, y: 2),
        currentPosition: const Position(x: 2, y: 2),
      ),
      Tile(
        value: 5,
        source: 'assets/img/tiles/uan/uan_5.png',
        validPosition: const Position(x: 3, y: 2),
        currentPosition: const Position(x: 3, y: 2),
      ),
      Tile(
        value: 6,
        source: 'assets/img/tiles/uan/uan_6.png',
        validPosition: const Position(x: 1, y: 3),
        currentPosition: const Position(x: 1, y: 3),
      ),
      Tile(
        value: 7,
        source: 'assets/img/tiles/uan/uan_7.png',
        validPosition: const Position(x: 2, y: 3),
        currentPosition: const Position(x: 2, y: 3),
      ),
      Tile(
        value: 8,
        source: 'assets/img/tiles/uan/uan_8.png',
        validPosition: const Position(x: 3, y: 3),
        currentPosition: const Position(x: 3, y: 3),
      ),
    ];

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    final tiles = mockTiles();
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: spaceContainerDecoration,
      height: size.width - 30,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return numbers[index] != 0
              ? AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: BoardTile(
                    tile: tiles[index],
                    onPressed: () => clickGrid(index),
                  ),
                )
              : const SizedBox.shrink();
        },
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
        // numbers[numbers.indexOf(0)] = numbers[index];
        // numbers[index] = 0;
        _alignment = Alignment.bottomCenter;
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
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber,
          boxShadow: const [BoxShadow(offset: Offset(0, 10))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: AssetImage(tile.source),
            fit: BoxFit.cover,
          ),
        ),
        // child: Center(
        //   child: Text('${tile.currentPosition}'),
        // ),
      ),
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
