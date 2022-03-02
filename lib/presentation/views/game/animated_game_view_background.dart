import 'package:flutter/material.dart';

class AnimatedGameViewBackground extends StatefulWidget {
  const AnimatedGameViewBackground._({
    Key? key,
    required this.background,
    required this.foreground,
    required this.bigMoon,
    required this.planet,
    required this.blueMoon,
    required this.ground,
  }) : super(key: key);

  factory AnimatedGameViewBackground.mobile() {
    return const AnimatedGameViewBackground._(
      background: 'assets/img/backgrounds/game_view/background_mobile.png',
      foreground: 'assets/img/backgrounds/game_view/foreground_mobile.png',
      bigMoon: 'assets/img/backgrounds/game_view/big_moon_mobile.png',
      planet: 'assets/img/backgrounds/game_view/planet_mobile.png',
      blueMoon: 'assets/img/backgrounds/game_view/blue_moon_mobile.png',
      ground: 'assets/img/backgrounds/game_view/ground_mobile.png',
    );
  }

  factory AnimatedGameViewBackground.desktop() {
    return const AnimatedGameViewBackground._(
      background: 'assets/img/backgrounds/game_view/background_desktop.png',
      foreground: 'assets/img/backgrounds/game_view/foreground_desktop.png',
      bigMoon: 'assets/img/backgrounds/game_view/big_moon_desktop.png',
      planet: 'assets/img/backgrounds/game_view/planet_desktop.png',
      blueMoon: 'assets/img/backgrounds/game_view/blue_moon_desktop.png',
      ground: 'assets/img/backgrounds/game_view/ground_desktop.png',
    );
  }

  final String background;
  final String foreground;
  final String bigMoon;
  final String planet;
  final String blueMoon;
  final String ground;

  @override
  State<AnimatedGameViewBackground> createState() =>
      _AnimatedGameViewBackgroundState();
}

class _AnimatedGameViewBackgroundState extends State<AnimatedGameViewBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _planetController;
  late Animation<double> _animationGround;
  late Animation<double> _animationPlanet;

  String get background => widget.background;
  String get foreground => widget.foreground;
  String get bigMoon => widget.bigMoon;
  String get planet => widget.planet;
  String get blueMoon => widget.blueMoon;
  String get ground => widget.ground;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _planetController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    _animationGround = Tween<double>(
      begin: 0,
      end: 25,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    );

    _animationPlanet = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _planetController,
        curve: const Interval(0, 1),
      ),
    );

    _controller
      ..forward()
      ..repeat(reverse: true);
    _planetController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _planetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final size = MediaQuery.of(context).size;
          return Stack(
            children: [
              _buildBackground(size),
              _buildBlueMoon(size),
              _buildBigMoon(size),
              _buildPlanet(size),
              _buildForeground(size),
              _buildGround(size),
            ],
          );
        });
  }

  SizedBox _buildBackground(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Image(
        image: AssetImage(background),
        fit: BoxFit.cover,
      ),
    );
  }

  Positioned _buildGround(Size size) {
    return Positioned(
      bottom: 0 - _animationGround.value,
      height: size.height,
      width: size.width,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Image(
          image: AssetImage(ground),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  SizedBox _buildForeground(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Image(
        image: AssetImage(foreground),
        fit: BoxFit.cover,
      ),
    );
  }

  Positioned _buildPlanet(Size size) {
    return Positioned(
      top: -300 + 300 * _animationPlanet.value,
      left:
          (-1 * size.width * 0.3) + (size.width * 0.3 * _animationPlanet.value),
      height: size.height,
      width: size.width,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Image(
          image: AssetImage(planet),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Positioned _buildBigMoon(Size size) {
    return Positioned(
      top: 0 + _animationGround.value,
      height: size.height,
      width: size.width,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Image(
          image: AssetImage(bigMoon),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Positioned _buildBlueMoon(Size size) {
    return Positioned(
      top: 0 - _animationGround.value,
      height: size.height,
      width: size.width,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Image(
          image: AssetImage(blueMoon),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
