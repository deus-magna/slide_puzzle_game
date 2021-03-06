import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedHistoryViewBackground extends StatefulWidget {
  const AnimatedHistoryViewBackground._({
    Key? key,
    required this.background,
    required this.planet,
    this.moon,
    required this.rocket,
    required this.clouds,
  }) : super(key: key);

  factory AnimatedHistoryViewBackground.mobile() {
    return const AnimatedHistoryViewBackground._(
      background: 'assets/img/backgrounds/history_view/background_mobile.png',
      planet: 'assets/img/backgrounds/history_view/planet_mobile.png',
      rocket: 'assets/img/backgrounds/history_view/rocket_mobile.png',
      clouds: 'assets/img/backgrounds/history_view/clouds_mobile.png',
    );
  }

  factory AnimatedHistoryViewBackground.desktop() {
    return const AnimatedHistoryViewBackground._(
      background: 'assets/img/backgrounds/history_view/background_desktop.png',
      planet: 'assets/img/backgrounds/history_view/planet_desktop.png',
      moon: 'assets/img/backgrounds/history_view/moon_desktop.png',
      rocket: 'assets/img/backgrounds/history_view/rocket_desktop.png',
      clouds: 'assets/img/backgrounds/history_view/clouds_desktop.png',
    );
  }

  final String background;

  final String planet;
  final String? moon;
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
  late Animation<double> _animationMoon;

  String get background => widget.background;

  String? get moon => widget.moon;
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
      duration: const Duration(seconds: 40),
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

    _animationMoon =
        Tween<double>(begin: 0, end: math.pi * 2).animate(_planetController);

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
    final radians = _animationMoon.value;
    const radius = 100;
    final startPoint =
        Offset(radius * math.cos(radians), radius * math.sin(radians));

    if (moon != null) {
      return Positioned(
        top: startPoint.dy * 3,
        left: startPoint.dx * 7,
        // top: (size.height * 0.071) * startPoint.dy,
        // left: (size.width * 0.53) * startPoint.dx,
        height: size.height * 0.20,
        width: size.height * 0.20,
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_planetController),
          child: Image(
            image: AssetImage(moon!),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
