import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key, required this.child, required this.image})
      : super(key: key);

  final Widget child;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width).clamp(200, 450),
      child: Stack(
        children: <Widget>[
          _buildCard(context),
          Positioned(
            left: 20,
            right: 20,
            child: Image(
              height: MediaQuery.of(context).size.height * 0.25,
              image: AssetImage(image),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final imageHeight = (MediaQuery.of(context).size.height * 0.25) / 2;

    return Container(
      margin: EdgeInsets.only(top: imageHeight),
      decoration: missionCompleteDialogDecoration,
      child: Container(
        padding: EdgeInsets.only(
          top: imageHeight + 16.0,
          bottom: 14,
          left: 14,
          right: 14,
        ),
        child: child,
      ),
    );
  }
}
