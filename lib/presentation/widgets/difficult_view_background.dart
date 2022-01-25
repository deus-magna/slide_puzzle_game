import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';

class DifficultViewBackground extends StatelessWidget {
  const DifficultViewBackground({
    Key? key,
    required this.backgroundImage,
  }) : super(key: key);

  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: -36.0.scale(size),
          right: -102.0.scale(size),
          height: size.height * 0.33,
          child: const Image(
            image: AssetImage('assets/img/characters/uan.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        Positioned(
          top: -70.0.scale(size),
          left: -140.0.scale(size),
          height: size.height * 0.31,
          child: const Image(
            image: AssetImage('assets/img/characters/ubbi.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        Positioned(
          bottom: -30.0.scale(size),
          left: -120.0.scale(size),
          height: size.height * 0.28,
          child: const Image(
            image: AssetImage('assets/img/characters/inky.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        Positioned(
          bottom: -90.0.scale(size),
          right: -140.0.scale(size),
          height: size.height * 0.44,
          child: const Image(
            image: AssetImage('assets/img/characters/flamfy.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }
}
