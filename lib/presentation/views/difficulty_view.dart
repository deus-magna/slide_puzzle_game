import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/widgets/difficult_view_background.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const constraints = BoxConstraints(minWidth: 88, minHeight: 60);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const DifficultViewBackground(
            backgroundImage:
                'assets/img/backgrounds/difficult_view_background.png',
          ),
          SizedBox(
            width: size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SpaceButton(
                  onPressed: () => Navigator.of(context).pushNamed('/test'),
                  title: AppLocalizations.of(context).difficultEasy,
                  constraints: constraints,
                ),
                const SizedBox(height: 25),
                SpaceButton(
                  onPressed: () => print('selected'),
                  title: AppLocalizations.of(context).difficultMedium,
                  constraints: constraints,
                ),
                const SizedBox(height: 25),
                SpaceButton(
                  onPressed: () => print('selected'),
                  title: AppLocalizations.of(context).difficultHard,
                  constraints: constraints,
                ),
                const SizedBox(height: 25),
                SpaceButton(
                  onPressed: () => print('selected'),
                  title: AppLocalizations.of(context).difficultGooLevel,
                  constraints: constraints,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SpaceButton extends StatelessWidget {
  const SpaceButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.constraints = const BoxConstraints(minWidth: 88, minHeight: 36),
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;
  final Color color;
  final Color textColor;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        constraints: constraints,
        alignment: Alignment.center,
        decoration: alienButtonDecoration,
        child: Text(
          title,
          style: Theme.of(context).textTheme.button!.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
