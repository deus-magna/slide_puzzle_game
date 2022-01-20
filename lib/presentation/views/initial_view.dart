import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';

class InitialView extends StatelessWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            PuzzleBoard(),
            Menu(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Slide Puzzle'));
  }
}

class PuzzleBoard extends StatelessWidget {
  PuzzleBoard({Key? key}) : super(key: key);

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
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 3, color: Colors.yellow),
      ),
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
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class BoardTile extends StatelessWidget {
  const BoardTile({Key? key, required this.tile}) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber,
        boxShadow: const [BoxShadow(offset: Offset(0, 10))],
      ),
      child: Center(
        child: Text('${tile.currentPosition}'),
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
