import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/utils/utils.dart' as utils;
import 'package:slide_puzzle_game/data/models/alien_entry.dart';
import 'package:slide_puzzle_game/domain/use_cases/get_best_results_for_alien.dart';
import 'package:slide_puzzle_game/domain/use_cases/is_alien_solved.dart';
import 'package:slide_puzzle_game/injection_container.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/views/history/history_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_bar.dart';

class AlienAlbumView extends StatelessWidget {
  const AlienAlbumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          HistoryViewBackground(),
          AlienAlbumBody(),
        ],
      ),
    );
  }
}

class AlienAlbumBody extends StatelessWidget {
  const AlienAlbumBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _aliens = _buildAliens(context);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        final isTablet =
            sizingInformation.deviceScreenType == DeviceScreenType.tablet;
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpaceBar(),
              Text(
                AppLocalizations.of(context).albumTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFCF33E5),
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: isDesktop
                    ? SizedBox(
                        width: (size.width / 1.5).clamp(750, 800),
                        child: GridView.count(
                            crossAxisCount: 2,
                            padding: const EdgeInsets.only(bottom: 20),
                            crossAxisSpacing: 40,
                            children: _aliens
                                .map((AlienEntry alien) =>
                                    AlienEntryTile(alienEntry: alien))
                                .toList()),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? size.width * 0.15 : 20),
                        child: ListView(
                            children: _aliens
                                .map((AlienEntry alien) =>
                                    AlienEntryTile(alienEntry: alien))
                                .toList()),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<AlienEntry> _buildAliens(BuildContext context) {
    final isAlienSolved = IsAlienSolved(sl());
    final getBestResultsForAlien = GetBestResultsForAlien(sl());
    return <AlienEntry>[
      AlienEntry(
        name: 'Uan',
        wieght: '20 kg',
        height: '90 cm',
        nature: AppLocalizations.of(context).uanNature,
        imagePath: 'assets/img/entries/uan.png',
        isSolved: isAlienSolved(alienName: 'uan'),
        bestMoves: getBestResultsForAlien(alienName: 'uan_results').first,
        bestTime: getBestResultsForAlien(alienName: 'uan_results').last,
        description: AppLocalizations.of(context).uanDescription,
      ),
      AlienEntry(
        name: 'Lemhost',
        wieght: '42 kg',
        height: '150 cm',
        nature: AppLocalizations.of(context).lemhostNature,
        imagePath: 'assets/img/entries/lemhost.png',
        isSolved: isAlienSolved(alienName: 'lemhost'),
        bestMoves: getBestResultsForAlien(alienName: 'lemhost_results').first,
        bestTime: getBestResultsForAlien(alienName: 'lemhost_results').last,
        description: AppLocalizations.of(context).lemhostDescription,
      ),
      AlienEntry(
        name: 'Balloopus',
        wieght: '8 kg',
        height: '115 cm',
        nature: AppLocalizations.of(context).balloopusNature,
        imagePath: 'assets/img/entries/balloopus.png',
        isSolved: isAlienSolved(alienName: 'balloopus'),
        bestMoves: getBestResultsForAlien(alienName: 'balloopus_results').first,
        bestTime: getBestResultsForAlien(alienName: 'balloopus_results').last,
        description: AppLocalizations.of(context).balloopusDescription,
      ),
      AlienEntry(
        name: 'Bathead',
        wieght: '34 kg',
        height: '100 cm',
        nature: AppLocalizations.of(context).batheadNature,
        imagePath: 'assets/img/entries/bathead.png',
        isSolved: isAlienSolved(alienName: 'bathead'),
        bestMoves: getBestResultsForAlien(alienName: 'bathead_results').first,
        bestTime: getBestResultsForAlien(alienName: 'bathead_results').last,
        description: AppLocalizations.of(context).batheadDescription,
      ),
      AlienEntry(
        name: 'Biglaught',
        wieght: '120 kg',
        height: '170 cm',
        nature: AppLocalizations.of(context).biglaughtNature,
        imagePath: 'assets/img/entries/biglaught.png',
        isSolved: isAlienSolved(alienName: 'biglaught'),
        bestMoves: getBestResultsForAlien(alienName: 'biglaught_results').first,
        bestTime: getBestResultsForAlien(alienName: 'biglaught_results').last,
        description: AppLocalizations.of(context).biglaughtDescription,
      ),
      AlienEntry(
        name: 'Inky',
        wieght: '15 kg',
        height: '80 cm',
        nature: AppLocalizations.of(context).inkyNature,
        imagePath: 'assets/img/entries/inky.png',
        isSolved: isAlienSolved(alienName: 'inky'),
        bestMoves: getBestResultsForAlien(alienName: 'inky_results').first,
        bestTime: getBestResultsForAlien(alienName: 'inky_results').last,
        description: AppLocalizations.of(context).inkyDescription,
      ),
      AlienEntry(
        name: 'Ubbi',
        wieght: '80 kg',
        height: '120 cm',
        nature: AppLocalizations.of(context).ubbiNature,
        imagePath: 'assets/img/entries/ubbi.png',
        isSolved: isAlienSolved(alienName: 'ubbi'),
        bestMoves: getBestResultsForAlien(alienName: 'ubbi_results').first,
        bestTime: getBestResultsForAlien(alienName: 'ubbi_results').last,
        description: AppLocalizations.of(context).ubbiDescription,
      ),
      AlienEntry(
        name: 'Tentamoon',
        wieght: '20 kg',
        height: '90 cm',
        nature: AppLocalizations.of(context).tentamoonNature,
        imagePath: 'assets/img/entries/tentamoon.png',
        isSolved: isAlienSolved(alienName: 'tentamoon'),
        bestMoves: getBestResultsForAlien(alienName: 'tentamoon_results').first,
        bestTime: getBestResultsForAlien(alienName: 'tentamoon_results').last,
        description: AppLocalizations.of(context).tentamoonDescription,
      ),
      AlienEntry(
        name: 'Flamfy',
        wieght: '57 kg',
        height: '150 cm',
        nature: AppLocalizations.of(context).flamfyNature,
        imagePath: 'assets/img/entries/flamfy.png',
        isSolved: isAlienSolved(alienName: 'flamfy'),
        bestMoves: getBestResultsForAlien(alienName: 'flamfy_results').first,
        bestTime: getBestResultsForAlien(alienName: 'flamfy_results').last,
        description: AppLocalizations.of(context).flamfyDescription,
      ),
    ];
  }
}

class AlienEntryTile extends StatelessWidget {
  const AlienEntryTile({
    Key? key,
    required this.alienEntry,
  }) : super(key: key);

  final AlienEntry alienEntry;
  @override
  Widget build(BuildContext context) {
    final shadow =
        alienEntry.imagePath.substring(0, alienEntry.imagePath.length - 4);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 3, color: pinkBorder),
          color: Colors.black.withOpacity(0.3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.star_rate_rounded,
                color: Colors.yellow,
              ),
              const SizedBox(width: 10),
              Text(
                alienEntry.isSolved
                    ? '${AppLocalizations.of(context).gameMoves}: ${alienEntry.bestMoves} / ${AppLocalizations.of(context).gameTimer}: ${utils.readableTimer(alienEntry.bestTime)}'
                    : '${AppLocalizations.of(context).gameMoves}: -- / ${AppLocalizations.of(context).gameTimer}: --',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                alienEntry.isSolved
                    ? alienEntry.imagePath
                    : '${shadow}_shadow.png',
                fit: BoxFit.contain,
                width: 150,
                height: 150,
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      alienEntry.isSolved ? alienEntry.name : '--',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFCF33E5),
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      alienEntry.isSolved
                          ? '''
Peso: ${alienEntry.wieght}\nAltura: ${alienEntry.height}\nNaturaleza: ${alienEntry.nature}'''
                          : 'Peso: ??\nAltura: ??\nNaturaleza: ??',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            alienEntry.isSolved
                ? alienEntry.description
                : 'Aun no existen datos',
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
