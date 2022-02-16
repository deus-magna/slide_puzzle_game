import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/views/alien_album/alien_album_view.dart';
import 'package:slide_puzzle_game/presentation/views/difficulty_view.dart';
import 'package:slide_puzzle_game/presentation/views/history/history_view.dart';
import 'package:slide_puzzle_game/presentation/widgets/home_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_bar.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';
import 'package:slide_puzzle_game/core/utils/utils.dart' as utils;

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
    const padding = EdgeInsets.symmetric(horizontal: 10);
    const duration = 800;
    final size = MediaQuery.of(context).size;
    final constraints = BoxConstraints(
        maxWidth: (size.width / 2).clamp(200, 300), minHeight: 60);

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpaceBar(showBackButton: false),
          Expanded(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      PlayButton(
                        onPressed: () =>
                            pushView(child: const DifficultyView()),
                      ),
                      const SizedBox(height: 30),
                      SpaceButton(
                        title: AppLocalizations.of(context).homeAlbum,
                        padding: padding,
                        onPressed: () =>
                            pushView(child: const AlienAlbumView()),
                        constraints: constraints,
                      ),
                      const SizedBox(height: 30),
                      SpaceButton(
                        title: AppLocalizations.of(context).homeRanking,
                        padding: padding,
                        onPressed: () {
                          utils.showMissionCompleteDialog(
                            context,
                            title: AppLocalizations.of(context).missionComplete,
                            timer: '02:14',
                            label: AppLocalizations.of(context).totalMoves,
                            moves: '24',
                            button: AppLocalizations.of(context).levelsButton,
                            onPressed: () {
                              context.read<AudioCubit>().playMenuMusic();
                              Navigator.of(context).pop();
                            },
                            album: AppLocalizations.of(context).albumButton,
                          );
                        },
                        constraints: constraints,
                      ),
                      const SizedBox(height: 30),
                      SpaceButton(
                        title: AppLocalizations.of(context).homeHistory,
                        padding: padding,
                        duration: const Duration(milliseconds: duration * 2),
                        onPressed: () => pushView(child: const HistoryView()),
                        constraints: constraints,
                      ),
                      const SizedBox(height: 30),
                      SpaceButton(
                        title: AppLocalizations.of(context).homeCredits,
                        padding: padding,
                        duration: const Duration(milliseconds: duration * 3),
                        constraints: constraints,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void pushView({required Widget child}) {
    player.replay(context);
    Navigator.of(context).push<void>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
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
