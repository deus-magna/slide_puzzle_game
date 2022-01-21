import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.backgroundImage,
  }) : super(key: key);

  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          child: Image(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
