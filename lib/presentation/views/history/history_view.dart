import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/views/history/history_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_bar.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          HistoryViewBackground(),
          HistoryViewBody(),
        ],
      ),
    );
  }
}

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: isDesktop
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              const SpaceBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: isDesktop
                        ? size.width / 3
                        : double.infinity.clamp(200, 350),
                    // : (size.width / 3).clamp(200, 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppLocalizations.of(context).historyTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFCF33E5),
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).historySubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFDB58BC),
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 3, color: pinkBorder),
                              color: Colors.black.withOpacity(0.3)),
                          child: Text(
                            AppLocalizations.of(context).historyMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
