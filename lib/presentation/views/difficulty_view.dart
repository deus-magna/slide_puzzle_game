import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/widgets/difficult_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const constraints = BoxConstraints(minWidth: 88, minHeight: 60);
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                  onPressed: () => Navigator.of(context).pushNamed('/game'),
                  title: AppLocalizations.of(context).difficultEasy,
                ),
                const SizedBox(height: 25),
                SpaceButton(
                  onPressed: () => print('selected'),
                  title: AppLocalizations.of(context).difficultMedium,
                ),
                const SizedBox(height: 25),
                SpaceButton(
                  onPressed: () => print('selected'),
                  title: AppLocalizations.of(context).difficultHard,
                ),
                const SizedBox(height: 25),
                SpaceButton(
                  onPressed: () => print('selected'),
                  title: AppLocalizations.of(context).difficultGooLevel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
