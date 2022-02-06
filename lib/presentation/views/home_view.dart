import 'package:flutter/material.dart';
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

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 90);

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpaceButton(
            title: AppLocalizations.of(context).homeRanking,
            padding: padding,
          ),
          SpaceButton(
            title: AppLocalizations.of(context).homeHistory,
            padding: padding,
          ),
          SpaceButton(
            title: AppLocalizations.of(context).homeCredits,
            padding: padding,
          ),
        ],
      ),
    );
  }
}
