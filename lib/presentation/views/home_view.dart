import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/src/provider.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/widgets/home_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          HomeViewBackground(),
          HomeViewBody(),
        ],
      ),
    );
  }
}

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setAsset('assets/audio/space_coin.mp3');
    context.read<AudioCubit>().playMenuMusic();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 90);

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlayButton(
            onPressed: () {
              player.replay();
              Navigator.of(context).pushNamed('/difficult');
            },
          ),
          const SizedBox(height: 30),
          SpaceButton(
            title: AppLocalizations.of(context).homeRanking,
            padding: padding,
          ),
          const SizedBox(height: 30),
          SpaceButton(
            title: AppLocalizations.of(context).homeHistory,
            padding: padding,
          ),
          const SizedBox(height: 30),
          SpaceButton(
            title: AppLocalizations.of(context).homeCredits,
            padding: padding,
          ),
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
}
