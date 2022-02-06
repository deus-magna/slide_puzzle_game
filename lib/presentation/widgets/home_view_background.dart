import 'package:flutter/material.dart';

class HomeViewBackground extends StatelessWidget {
  const HomeViewBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        SizedBox(
          width: double.infinity,
          child: Image(
            image:
                AssetImage('assets/img/backgrounds/home_view_background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
