import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/extensions.dart';

class HomeViewBackground extends StatefulWidget {
  const HomeViewBackground({Key? key}) : super(key: key);

  @override
  State<HomeViewBackground> createState() => _HomeViewBackgroundState();
}

class _HomeViewBackgroundState extends State<HomeViewBackground>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
      upperBound: 50,
    );

    // controller
    //   ..addListener(() {
    //     setState(() {});
    //   })
    //   ..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Image(
            image:
                AssetImage('assets/img/backgrounds/home_view_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 85,
          right: -48,
          height: size.height * 0.475,
          child: const Image(
            image: AssetImage('assets/img/shadow.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        Positioned(
          bottom: 85 + controller.value,
          right: -48,
          height: size.height * 0.475,
          child: const Image(
            image: AssetImage('assets/img/rocket.png'),
            fit: BoxFit.fitHeight,
          ),
        )
      ],
    );
  }
}
