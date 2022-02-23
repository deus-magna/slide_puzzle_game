import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/data/models/game_params.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/cubits/difficult_cubit/difficult_cubit.dart';
import 'package:slide_puzzle_game/presentation/cubits/game_cubit/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/views/game/game_view.dart';
import 'package:slide_puzzle_game/presentation/widgets/difficult_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_bar.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => DifficultCubit(),
        child: BlocConsumer<DifficultCubit, DifficultState>(
          listener: (context, state) async {
            if (state is DifficultLoaded) {
              unawaited(_pushGameView(context, state.gameParams));
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                const DifficultViewBackground(),
                if (state is DifficultLoading || state is DifficultLoaded)
                  Center(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 3, color: pinkBorder),
                            color: Colors.black.withOpacity(0.3)),
                        height: (size.height * 0.2).clamp(150, 200),
                        width: double.infinity.clamp(200, 350),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context).difficultLoading,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        )),
                  )
                else
                  _buildBody(size, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(Size size, BuildContext context) {
    const duration = 800;
    final size = MediaQuery.of(context).size;
    final constraints = BoxConstraints(
        maxWidth: (size.width / 2).clamp(200, 300), minHeight: 60);
    return SafeArea(
      child: Column(
        children: [
          const SpaceBar(color: Colors.black),
          Expanded(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      SpaceButton(
                        onPressed: () =>
                            _loadAlienAssets(context, GameDifficult.easy),
                        title: AppLocalizations.of(context).difficultEasy,
                        constraints: constraints,
                      ),
                      const SizedBox(height: 25),
                      SpaceButton(
                        onPressed: () =>
                            _loadAlienAssets(context, GameDifficult.medimum),
                        title: AppLocalizations.of(context).difficultMedium,
                        duration: const Duration(milliseconds: duration * 2),
                        constraints: constraints,
                      ),
                      const SizedBox(height: 25),
                      SpaceButton(
                        onPressed: () =>
                            _loadAlienAssets(context, GameDifficult.hard),
                        title: AppLocalizations.of(context).difficultHard,
                        duration: const Duration(milliseconds: duration * 3),
                        constraints: constraints,
                      ),
                      const SizedBox(height: 25),
                      SpaceButton(
                        onPressed: () =>
                            _loadAlienAssets(context, GameDifficult.godLevel),
                        title: AppLocalizations.of(context).difficultGooLevel,
                        duration: const Duration(milliseconds: duration * 4),
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

  void _loadAlienAssets(
    BuildContext context,
    GameDifficult gameDifficult,
  ) {
    Timer(const Duration(milliseconds: 50),
        () => context.read<DifficultCubit>().loadAssets(gameDifficult));
  }

  Future<void> _pushGameView(
      BuildContext context, GameParams gameParams) async {
    await Navigator.of(context).push<void>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: GameView(
              gameParams: gameParams,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
    context.read<DifficultCubit>().initialState();
  }
}
