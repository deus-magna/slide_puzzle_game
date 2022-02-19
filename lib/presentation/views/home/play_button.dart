import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final Function()? onPressed;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
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
    return GestureDetector(
      onTap: () => _onPressed(context),
      child: Container(
        alignment: Alignment.center,
        decoration: playButtonDecoration,
        child: const Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
          size: 120,
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    player.replay(context);
    widget.onPressed?.call();
  }
}
