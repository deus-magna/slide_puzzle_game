import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';

class SpaceButton extends StatefulWidget {
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
    this.isShortButton = false,
    this.hasSound = true,
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
  final bool isShortButton;
  final bool hasSound;

  @override
  State<SpaceButton> createState() => _SpaceButtonState();
}

class _SpaceButtonState extends State<SpaceButton> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setAsset('assets/audio/space_coin.mp3');
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.animate
        ? TranslateAnimation(
            offsetDirection: widget.offsetDirection,
            duration: widget.duration,
            child: _buildButton(context),
          )
        : _buildButton(context);
  }

  Padding _buildButton(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextButton(
        onPressed: () => _onPressed(context),
        child: Container(
          constraints: widget.constraints,
          alignment: Alignment.center,
          decoration: alienButtonDecoration,
          child: Text(
            widget.title,
            style: widget.isShortButton
                ? Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: widget.textColor)
                    .copyWith(fontSize: 22)
                : Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: widget.textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    if (widget.hasSound) {
      player.replay(context);
    }
    widget.onPressed?.call();
  }
}
