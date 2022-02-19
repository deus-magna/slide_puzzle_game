import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
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
    this.offsetDirection = Axis.horizontal,
    this.duration = const Duration(milliseconds: 800),
    this.animate = true,
    this.shortButton = false,
    // this.constraints = const BoxConstraints(minWidth: 88, minHeight: 36),
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;
  final Color color;
  final Color textColor;
  final BoxConstraints constraints;
  final EdgeInsets padding;
  final Axis offsetDirection;
  final Duration duration;
  final bool animate;
  final bool shortButton;

  @override
  Widget build(BuildContext context) {
    return animate
        ? TranslateAnimation(
            offsetDirection: offsetDirection,
            duration: duration,
            child: _buildButton(context),
          )
        : _buildButton(context);
  }

  Padding _buildButton(BuildContext context) {
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
            style: shortButton
                ? Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: textColor)
                    .copyWith(fontSize: 22)
                : Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
