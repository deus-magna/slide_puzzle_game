import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AnimatedHistoryViewBackground extends StatefulWidget {
  const AnimatedHistoryViewBackground._({
    Key? key,
    required this.background,
    required this.stars,
    required this.planet,
    required this.moon,
    required this.rocket,
    required this.clouds,
  }) : super(key: key);

  factory AnimatedHistoryViewBackground.mobile() {
    return const AnimatedHistoryViewBackground._(
      background: 'assets/img/backgrounds/history_view/background_desktop.png',
      stars: 'assets/img/backgrounds/history_view/stars_desktop.png',
      planet: 'assets/img/backgrounds/history_view/planet_desktop.png',
      moon: 'assets/img/backgrounds/history_view/moon_desktop.png',
      rocket: 'assets/img/backgrounds/history_view/rocket_desktop.png',
      clouds: 'assets/img/backgrounds/history_view/clouds_desktop.png',
    );
  }

  factory AnimatedHistoryViewBackground.desktop() {
    return const AnimatedHistoryViewBackground._(
      background: 'assets/img/backgrounds/history_view/background_desktop.png',
      stars: 'assets/img/backgrounds/history_view/stars_desktop.png',
      planet: 'assets/img/backgrounds/history_view/planet_desktop.png',
      moon: 'assets/img/backgrounds/history_view/moon_desktop.png',
      rocket: 'assets/img/backgrounds/history_view/rocket_desktop.png',
      clouds: 'assets/img/backgrounds/history_view/clouds_desktop.png',
    );
  }

  final String background;
  final String stars;
  final String planet;
  final String moon;
  final String rocket;
  final String clouds;

  @override
  State<AnimatedHistoryViewBackground> createState() =>
      _AnimatedHistoryViewBackgroundState();
}

class _AnimatedHistoryViewBackgroundState
    extends State<AnimatedHistoryViewBackground> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _planetController;
  late AnimationController _rocketController;
  late Animation<double> _animationClouds;

  String get background => widget.background;
  String get stars => widget.stars;
  String get moon => widget.moon;
  String get planet => widget.planet;
  String get rocket => widget.rocket;
  String get clouds => widget.clouds;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _planetController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 120),
    );

    _rocketController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    _animationClouds = Tween<double>(
      begin: 0,
      end: 25,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    );

    _controller
      ..forward()
      ..repeat(reverse: true);
    _planetController
      ..forward()
      ..repeat();
    _rocketController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _planetController.dispose();
    _rocketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge(
            [_controller, _planetController, _rocketController]),
        builder: (context, child) {
          final size = MediaQuery.of(context).size;
          return Stack(
            children: [
              _buildBackground(size),
              _buildStars(size),
              _buildMoon(size),
              _buildPlanet(size),
              _buildRocket(size),
              _buildClouds(size),
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

  Widget _buildStars(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Image(
        image: AssetImage(stars),
        fit: BoxFit.cover,
      ),
    );
  }

  Positioned _buildClouds(Size size) {
    return Positioned(
      bottom: 0 - _animationClouds.value,
      height: size.height,
      width: size.width,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Image(
          image: AssetImage(clouds),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRocket(Size size) {
    return Positioned(
      bottom:
          (-size.height * 0.5) + (size.height * 0.5) * _rocketController.value,
      left:
          (-size.height * 0.8) + (size.height * 0.8) * _rocketController.value,
      height: size.height,
      width: size.width,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Image(
          image: AssetImage(rocket),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Positioned _buildPlanet(Size size) {
    return Positioned(
      top: 0 - _animationClouds.value,
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

  Widget _buildMoon(Size size) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_planetController),
      child: Positioned(
        top: 0,
        height: size.height,
        width: size.width,
        child: Image(
          image: AssetImage(moon),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Widget _buildMobile() {
  //   final size = MediaQuery.of(context).size;
  //   return AnimatedBuilder(
  //     animation: _controller,
  //     builder: (context, child) {
  //       return Stack(
  //         children: [
  //           const SizedBox(
  //             width: double.infinity,
  //             child: Image(
  //               image: AssetImage(
  //                   'assets/img/backgrounds/history_view_background.png'),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           Positioned(
  //             top: 10 + (_animationMoon.value * 0.2) / 2,
  //             right: -(size.height * 0.25) + (_animationMoon.value * 0.2),
  //             height: size.height * 0.25,
  //             child: const Image(
  //               image: AssetImage('assets/img/moon.png'),
  //               fit: BoxFit.fitHeight,
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  // Widget _buildTablet() {
  //   final size = MediaQuery.of(context).size;
  //   return AnimatedBuilder(
  //     animation: _controller,
  //     builder: (context, child) {
  //       return Stack(
  //         children: [
  //           const SizedBox(
  //             width: double.infinity,
  //             height: double.infinity,
  //             child: Image(
  //               image: AssetImage(
  //                   'assets/img/backgrounds/history_view_background_tablet.png'),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           Positioned(
  //             top: 10 + (_animationMoon.value * 0.2) / 2,
  //             right: -(size.height * 0.25) + (_animationMoon.value * 0.2),
  //             height: size.height * 0.25,
  //             child: const Image(
  //               image: AssetImage('assets/img/moon.png'),
  //               fit: BoxFit.fitHeight,
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }
}
