import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/data/models/alien_entry.dart';
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
    final _aliens = _buildAliens();

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

  List<AlienEntry> _buildAliens() {
    final isAlienSolved = IsAlienSolved(sl());
    return <AlienEntry>[
      AlienEntry(
        name: 'Uan',
        wieght: '20 kg',
        height: '90 cm',
        nature: 'Amigable',
        src: 'assets/img/characters/uan.png',
        isSolved: isAlienSolved(alienName: 'Uan'),
        description:
            'Este alien es amigable y es uno de los mas fáciles de ver en este planeta, hay varios y su color depende de su estado de animo.',
      ),
      AlienEntry(
        name: 'Inky',
        wieght: '15 kg',
        height: '80 cm',
        nature: 'Intrepido',
        src: 'assets/img/characters/inky.png',
        isSolved: isAlienSolved(alienName: 'Inky'),
        description:
            'Son extremadamente curiosos, detectan rápidamente a otros seres vivos debido a que tiene varios ojos y un gran sentido del oido.',
      ),
      AlienEntry(
        name: 'Ubbi',
        wieght: '80 kg',
        height: '120 cm',
        nature: 'Timido',
        src: 'assets/img/characters/ubbi.png',
        isSolved: isAlienSolved(alienName: 'Ubbi'),
        description:
            'Es dificil de ver, se encuentra en lugares oscuros y se camufla muy bien con la fauna de este planea, es mas rapido de lo que parece',
      ),
      AlienEntry(
        name: 'Flamfy',
        wieght: '57 kg',
        height: '150 cm',
        nature: 'Agresivo',
        src: 'assets/img/characters/flamfy.png',
        isSolved: isAlienSolved(alienName: 'Flamfy'),
        description:
            'Este alien no esta bien emocionalmente, quema todo a su alrededor ya que puede escupir fuego, son peligrosos y territoriales, se debe tener mucho cuidado',
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
    final shadow = alienEntry.src.substring(0, alienEntry.src.length - 4);
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
            children: [
              Image.asset(
                alienEntry.isSolved ? alienEntry.src : '${shadow}_shadow.png',
                fit: BoxFit.contain,
                width: 150,
                height: 150,
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      alienEntry.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFCF33E5),
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      alienEntry.isSolved
                          ? 'Peso: ${alienEntry.wieght}\nAltura: ${alienEntry.height}\nNaturaleza: ${alienEntry.nature}'
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
