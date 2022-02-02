// import 'package:flutter/material.dart';
// import 'package:slide_puzzle_game/data/models/tile.dart';

// class TestView extends StatefulWidget {
//   TestView({Key? key}) : super(key: key);

//   @override
//   _TestViewState createState() => _TestViewState();
// }

// class _TestViewState extends State<TestView> {
//   AlignmentGeometry _alignment = Alignment.topCenter;
//   final size = 3;
//   final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(40),
//           height: double.infinity,
//           width: double.infinity,
//           child: Container(
//             color: Colors.green,
//             child: Column(
//               children: [
//                 ElevatedButton(
//                     onPressed: () {
//                       print('Si lo intenta');
//                       setState(() {
//                         _alignment = Alignment.bottomCenter;
//                       });
//                     },
//                     child: const Text('Mover')),
//                 Container(
//                   color: Colors.amber,
//                   height: 160,
//                   child: Stack(
//                     children: buildTiles(size, numbers),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void clickGrid() {}

//   List<Widget> buildTiles(int size, List<int> numbers) {
//     final tiles = mockTiles();

//     final animatedTiles = tiles
//         .map(
//           (tile) => AnimatedAlign(
//             alignment: FractionalOffset(
//               (tile.currentPosition.x - 1) / (size - 1),
//               (tile.currentPosition.y - 1) / (size - 1),
//             ),
//             duration: const Duration(seconds: 2),
//             child: !tile.isWhitespace
//                 ? _BoardTile(tile: tile, onPressed: () => clickGrid())
//                 : const SizedBox.shrink(),
//           ),
//         )
//         .toList();

//     return animatedTiles;
//   }

//   List<Tile> mockTiles() {
//     final tiles = <Tile>[
//       Tile(
//         isWhitespace: true,
//         source: '',
//         validPosition: const Position(x: 1, y: 1),
//         currentPosition: const Position(x: 1, y: 1),
//       ),
//       Tile(
//         source: 'assets/img/tiles/uan/uan_1.png',
//         validPosition: const Position(x: 2, y: 1),
//         currentPosition: const Position(x: 2, y: 1),
//       ),
//       Tile(
//         source: 'assets/img/tiles/uan/uan_2.png',
//         validPosition: const Position(x: 3, y: 1),
//         currentPosition: const Position(x: 3, y: 1),
//       ),
//       Tile(
//         source: 'assets/img/tiles/uan/uan_3.png',
//         validPosition: const Position(x: 1, y: 2),
//         currentPosition: const Position(x: 1, y: 2),
//       ),
//       Tile(
//         source: 'assets/img/tiles/uan/uan_4.png',
//         validPosition: const Position(x: 2, y: 2),
//         currentPosition: const Position(x: 2, y: 2),
//       ),
//       Tile(
//         source: 'assets/img/tiles/uan/uan_5.png',
//         validPosition: const Position(x: 3, y: 2),
//         currentPosition: const Position(x: 3, y: 2),
//       ),
//       Tile(
//         source: 'assets/img/tiles/uan/uan_6.png',
//         validPosition: const Position(x: 1, y: 3),
//         currentPosition: const Position(x: 1, y: 3),
//       ),
//       Tile(
//         source: 'assets/img/tiles/uan/uan_7.png',
//         validPosition: const Position(x: 2, y: 3),
//         currentPosition: const Position(x: 2, y: 3),
//       ),
//       Tile(
//         source: 'assets/img/tiles/uan/uan_8.png',
//         validPosition: const Position(x: 3, y: 3),
//         currentPosition: const Position(x: 3, y: 3),
//       ),
//     ];

//     return tiles;
//   }
// }

// class _BoardTile extends StatelessWidget {
//   const _BoardTile({Key? key, required this.tile, this.onPressed})
//       : super(key: key);

//   final Tile tile;
//   final Function()? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         padding: EdgeInsets.zero,
//       ),
//       onPressed: onPressed,
//       child: Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.amber,
//           boxShadow: const [BoxShadow(offset: Offset(0, 10))],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image(
//             image: AssetImage(tile.source),
//             fit: BoxFit.cover,
//           ),
//         ),
//         // child: Center(
//         //   child: Text('${tile.currentPosition}'),
//         // ),
//       ),
//     );
//   }
// }
