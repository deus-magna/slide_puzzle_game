import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';

class SpaceBar extends StatefulWidget {
  const SpaceBar({
    Key? key,
    this.color = Colors.white,
    this.onPressed,
    this.showBackButton = true,
  }) : super(key: key);

  final Color color;
  final Function()? onPressed;
  final bool showBackButton;

  @override
  State<SpaceBar> createState() => _SpaceBarState();
}

class _SpaceBarState extends State<SpaceBar> {
  Function()? get onPressed => widget.onPressed;
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setAsset('assets/audio/back_button.mp3');
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.showBackButton)
            TextButton(
              onPressed: () {
                player.replay(context);
                Navigator.of(context).pop();
                onPressed?.call();
              },
              child: Text(
                AppLocalizations.of(context).backButton,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: widget.color),
              ),
            )
          else
            const SizedBox.shrink(),
          BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      player.replay(context);
                      context.read<AudioCubit>().toogleSoudEffects();
                    },
                    icon: Icon(
                      state.isSoundEffectsMuted
                          ? Icons.music_off_rounded
                          : Icons.music_note_rounded,
                      color: widget.color,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      player.replay(context);
                      context.read<AudioCubit>().toogleMusic();
                    },
                    icon: Icon(
                      state.isAmbientMusicMuted
                          ? Icons.volume_off_rounded
                          : Icons.volume_up_rounded,
                      color: widget.color,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
