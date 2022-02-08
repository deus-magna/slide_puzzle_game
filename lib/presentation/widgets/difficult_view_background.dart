import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';

class DifficultViewBackground extends StatefulWidget {
  const DifficultViewBackground({
    Key? key,
    required this.backgroundImage,
  }) : super(key: key);

  final String backgroundImage;

  @override
  State<DifficultViewBackground> createState() =>
      _DifficultViewBackgroundState();
}

class _DifficultViewBackgroundState extends State<DifficultViewBackground>
    with TickerProviderStateMixin {
  late AnimationController uanController;
  late AnimationController inkyController;

  @override
  void initState() {
    super.initState();
    uanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      upperBound: 50,
    );

    inkyController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      upperBound: 30,
    );

    uanController
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);

    inkyController
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    uanController.dispose();
    inkyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image(
            image: AssetImage(widget.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: -36.0.scale(size),
          right: -102.0.scale(size),
          height: size.height * 0.33,
          child: Padding(
            padding: EdgeInsets.only(top: uanController.value),
            child: const Image(
              image: AssetImage('assets/img/characters/uan.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          top: -70.0.scale(size),
          left: -140.0.scale(size),
          height: size.height * 0.31,
          child: Padding(
            padding: EdgeInsets.only(top: uanController.value),
            child: const Image(
              image: AssetImage('assets/img/characters/ubbi.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          bottom: -30.0.scale(size),
          left: -120.0.scale(size),
          height: size.height * 0.28,
          child: Padding(
            padding: EdgeInsets.only(top: inkyController.value),
            child: const Image(
              image: AssetImage('assets/img/characters/inky.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          bottom: -90.0.scale(size),
          right: -140.0.scale(size),
          height: size.height * 0.44,
          child: Padding(
            padding: EdgeInsets.only(top: uanController.value),
            child: const Image(
              image: AssetImage('assets/img/characters/flamfy.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
