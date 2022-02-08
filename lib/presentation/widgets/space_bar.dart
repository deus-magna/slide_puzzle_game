import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';

class SpaceBar extends StatefulWidget {
  const SpaceBar({Key? key, this.color = Colors.white, this.onPressed})
      : super(key: key);

  final Color color;
  final Function()? onPressed;

  @override
  State<SpaceBar> createState() => _SpaceBarState();
}

class _SpaceBarState extends State<SpaceBar> {
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
          TextButton(
            onPressed: () {
              player.replay();
              Navigator.of(context).pop();

              widget.onPressed!();
            },
            child: Text(
              AppLocalizations.of(context).backButton,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: widget.color),
            ),
          ),
          BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  player.replay();
                  context.read<AudioCubit>().toogleMusic();
                },
                icon: Icon(
                  state.isMuted
                      ? Icons.volume_off_rounded
                      : Icons.volume_up_rounded,
                  color: widget.color,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
