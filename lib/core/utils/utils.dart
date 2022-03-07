import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/presentation/widgets/custom_dialog.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

String readableTimer(int duration) {
  final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
  final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
  return '$minutesStr:$secondsStr';
}

void showMissionCompleteDialog(BuildContext context,
    {required String title,
    required String timer,
    required String label,
    required String moves,
    required String button,
    required String album,
    required String share,
    required ScreenshotController controller,
    Function()? onPressed}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => Screenshot<void>(
      controller: controller,
      child: CustomDialog(
        image: 'assets/img/planet.png',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildTimer(timer, context),
            const SizedBox(height: 20),
            _buildTotalMoves(label, context, moves),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SpaceButton(
                      animate: false,
                      isShortButton: true,
                      onPressed: () {
                        context.read<AudioCubit>().playMenuMusic();
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                      title: button),
                ),
                Expanded(
                  child: SpaceButton(
                      animate: false,
                      isShortButton: true,
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/album', ModalRoute.withName('home'));
                      },
                      title: album),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SpaceButton(
                animate: false,
                isShortButton: true,
                onPressed: () => _shareScore(controller),
                title: share),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}

Future<void> _shareScore(ScreenshotController screenshotController) async {
  final tempDirectory = await getTemporaryDirectory();

  final path = await screenshotController.captureAndSave(tempDirectory.path);
  await Share.shareFiles([path!],
      subject: 'Check out my new score on Slide the Space');
}

Container _buildTotalMoves(String label, BuildContext context, String moves) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF95119B),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 3, color: const Color(0xFFB916C1)),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
        Text(
          moves,
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Row _buildTimer(String timer, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.timer_rounded,
        color: Colors.white,
        size: 30,
      ),
      const SizedBox(width: 10),
      Text(
        timer,
        style: Theme.of(context).textTheme.headline3,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

void showCustomAlert(BuildContext context,
    {required String img,
    required String title,
    required String message,
    required String button,
    Function()? onPressed}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => CustomDialog(
      image: img,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: SpaceButton(
                onPressed: onPressed == null
                    ? () => Navigator.of(context).pop()
                    : onPressed,
                title: button),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
