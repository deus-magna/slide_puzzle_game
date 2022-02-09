import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/colors.dart';

BoxDecoration missionCompleteDialogDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  border: Border.all(width: 5, color: const Color(0xFF690755)),
  boxShadow: const [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 10,
      offset: Offset(0, 10),
    ),
  ],
  gradient: LinearGradient(
    colors: [
      const Color(0xFF7D0F81),
      const Color(0xFFD25EFC).withOpacity(0.5),
      const Color(0x00FFFFFF),
    ],
    stops: const [0, 1, 0.502],
    begin: const Alignment(0.5, 0.263),
    end: const Alignment(0.511, 1.213),
  ),
);

BoxDecoration spaceContainerDecoration = BoxDecoration(
  color: purpleBackground.withOpacity(0.5),
  borderRadius: BorderRadius.circular(20),
  border: Border.all(width: 3, color: pinkBorder),
);

BoxDecoration alienButtonDecoration = BoxDecoration(
  color: Colors.purple,
  borderRadius: BorderRadius.circular(20),
  border: Border.all(
    width: 3,
    color: pinkBorder,
  ),
  boxShadow: const [BoxShadow(offset: Offset(0, 10))],
  gradient: spaceGradient,
);

BoxDecoration playButtonDecoration = BoxDecoration(
  shape: BoxShape.circle,
  border: Border.all(width: 3, color: pinkBorder),
  boxShadow: const [BoxShadow(offset: Offset(0, 6))],
  gradient: spaceGradient,
);

const spaceGradient = LinearGradient(
  colors: [purple, pink],
  begin: Alignment(-0.5, -1),
  end: Alignment(0.5, 3.5),
);
