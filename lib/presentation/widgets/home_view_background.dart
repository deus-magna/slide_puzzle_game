import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/extensions.dart';

class HomeViewBackground extends StatefulWidget {
  const HomeViewBackground({Key? key}) : super(key: key);

  @override
  State<HomeViewBackground> createState() => _HomeViewBackgroundState();
}

class _HomeViewBackgroundState extends State<HomeViewBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationRocket;
  late Animation<double> _animationShadow;
  late Animation<double> _animationStar;
  late Animation<double> _animationStar2;
  late Animation<double> _animationStar3;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _animationStar = Tween<double>(
      begin: 0.3,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.05, 0.6, curve: Curves.ease),
      ),
    );

    _animationStar2 = Tween<double>(
      begin: 0.3,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.ease),
      ),
    );

    _animationStar3 = Tween<double>(
      begin: 0.3,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.8, curve: Curves.ease),
      ),
    );

    _animationRocket = Tween<double>(
      begin: 0,
      end: 50,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    );

    _animationShadow = Tween<double>(
      begin: 1,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    );

    _controller
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Image(
                image: AssetImage(
                    'assets/img/backgrounds/home_view_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 80,
              right: 40,
              height: size.width * 0.2,
              child: Transform.scale(
                scale: _animationStar.value,
                child: const Image(
                  image: AssetImage('assets/img/star.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: 155,
              right: 0,
              height: size.width * 0.15,
              child: Transform.scale(
                scale: _animationStar2.value,
                child: const Image(
                  image: AssetImage('assets/img/star2.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.445,
              left: -10,
              height: size.width * 0.08,
              child: Transform.scale(
                scale: _animationStar3.value,
                child: const Image(
                  image: AssetImage('assets/img/star3.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              right: -48,
              height: size.width * 0.11,
              child: Transform.scale(
                scale: _animationShadow.value,
                child: const Image(
                  image: AssetImage('assets/img/shadow.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 85 + _animationRocket.value,
              right: -48,
              height: size.height * 0.475,
              child: const Image(
                image: AssetImage('assets/img/rocket.png'),
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        );
      },
    );
  }
}
