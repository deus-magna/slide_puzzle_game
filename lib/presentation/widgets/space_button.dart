import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';

class SpaceButton extends StatelessWidget {
  const SpaceButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.constraints = const BoxConstraints(minWidth: 88, minHeight: 60),
    this.padding = EdgeInsets.zero,
    // this.constraints = const BoxConstraints(minWidth: 88, minHeight: 36),
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;
  final Color color;
  final Color textColor;
  final BoxConstraints constraints;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          constraints: constraints,
          alignment: Alignment.center,
          decoration: alienButtonDecoration,
          child: Text(
            title,
            style:
                Theme.of(context).textTheme.button!.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
