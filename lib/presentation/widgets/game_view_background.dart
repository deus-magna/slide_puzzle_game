import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GameViewBackground extends StatefulWidget {
  const GameViewBackground({Key? key}) : super(key: key);

  @override
  State<GameViewBackground> createState() => _GameViewBackgroundState();
}

class _GameViewBackgroundState extends State<GameViewBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _planetController;
  late Animation<double> _animationGround;
  late Animation<double> _animationPlanet;

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
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => _buildMobile(),
      tablet: (BuildContext context) => _buildTablet(),
      desktop: (BuildContext context) => _buildDesktop(),
    );
  }

  Widget _buildMobile() {
    return AnimatedBuilder(
        animation: Listenable.merge([_controller, _planetController]),
        builder: (context, child) {
          final size = MediaQuery.of(context).size;
          return Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: const Image(
                  image: AssetImage(
                      'assets/img/backgrounds/game_view/background_mobile.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0 - _animationGround.value,
                height: size.height,
                width: size.width,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: const Image(
                    image: AssetImage(
                        'assets/img/backgrounds/game_view/blue_moon_mobile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: -300 + 300 * _animationPlanet.value,
                left: (-1 * size.width * 0.3) +
                    (size.width * 0.3 * _animationPlanet.value),
                height: size.height,
                width: size.width,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: const Image(
                    image: AssetImage(
                        'assets/img/backgrounds/game_view/planet_mobile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0 + _animationGround.value,
                height: size.height,
                width: size.width,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: const Image(
                    image: AssetImage(
                        'assets/img/backgrounds/game_view/big_moon_mobile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height,
                child: const Image(
                  image: AssetImage(
                      'assets/img/backgrounds/game_view/foreground_mobile.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0 - _animationGround.value,
                height: size.height,
                width: size.width,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: const Image(
                    image: AssetImage(
                        'assets/img/backgrounds/game_view/ground_mobile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildTablet() {
    return Stack(
      children: const [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage(
                'assets/img/backgrounds/game_view/game_view_background_desktop.png'),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktop() {
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
      child: const Image(
        image: AssetImage(
            'assets/img/backgrounds/game_view/game_view_background_desktop.png'),
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
        child: const Image(
          image: AssetImage(
              'assets/img/backgrounds/game_view/game_view_ground.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  SizedBox _buildForeground(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: const Image(
        image: AssetImage(
            'assets/img/backgrounds/game_view/game_view_foreground_desktop.png'),
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
        child: const Image(
          image: AssetImage(
              'assets/img/backgrounds/game_view/game_view_planet.png'),
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
        child: const Image(
          image: AssetImage(
              'assets/img/backgrounds/game_view/game_view_big_moon.png'),
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
        child: const Image(
          image: AssetImage(
              'assets/img/backgrounds/game_view/game_view_blue_moon.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
