import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GameViewBackground extends StatelessWidget {
  const GameViewBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => _buildMobile(),
      tablet: (BuildContext context) => _buildTablet(),
      desktop: (BuildContext context) => _buildDesktop(),
    );
  }

  Widget _buildMobile() {
    return Stack(
      children: const [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage(
                'assets/img/backgrounds/game_view_background_desktop.png'),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildTablet() {
    return Stack(
      children: const [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage(
                'assets/img/backgrounds/game_view_background_desktop.png'),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktop() {
    return Stack(
      children: const [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage(
                'assets/img/backgrounds/game_view_background_desktop.png'),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
