import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HistoryViewBackground extends StatefulWidget {
  const HistoryViewBackground({Key? key}) : super(key: key);

  @override
  State<HistoryViewBackground> createState() => _HistoryViewBackgroundState();
}

class _HistoryViewBackgroundState extends State<HistoryViewBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationMoon;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _animationMoon = Tween<double>(
      begin: 0,
      end: 3500,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1),
      ),
    );

    _controller
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => _buildMobile(),
      tablet: (BuildContext context) => _buildMobile(),
      desktop: (BuildContext context) => _buildDesktop(),
    );
  }

  Widget _buildMobile() {
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
                    'assets/img/backgrounds/history_view_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10 + (_animationMoon.value * 0.2) / 2,
              right: -(size.height * 0.25) + (_animationMoon.value * 0.2),
              height: size.height * 0.25,
              child: const Image(
                image: AssetImage('assets/img/moon.png'),
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildDesktop() {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image(
                image: AssetImage(
                    'assets/img/backgrounds/history_view_background_desktop.png'),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10 + (_animationMoon.value * 0.2) / 2,
              right: -(size.height * 0.25) + (_animationMoon.value * 0.2),
              height: size.height * 0.25,
              child: const Image(
                image: AssetImage('assets/img/moon.png'),
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        );
      },
    );
  }
}
