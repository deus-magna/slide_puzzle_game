import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';

class SpaceBar extends StatelessWidget {
  const SpaceBar({Key? key, this.color = Colors.white}) : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context).backButton,
              style:
                  Theme.of(context).textTheme.headline4!.copyWith(color: color),
            ),
          ),
          IconButton(
            onPressed: () => print('Pressed'),
            icon: Icon(
              Icons.volume_off_rounded,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
