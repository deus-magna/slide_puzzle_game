import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/colors.dart';

BoxDecoration alienButtonDecoration = BoxDecoration(
  color: Colors.purple,
  borderRadius: BorderRadius.circular(20),
  border: Border.all(
    width: 3,
    color: const Color(0xFFFA95FD),
  ),
  boxShadow: const [BoxShadow(offset: Offset(0, 10))],
  gradient: const LinearGradient(
    colors: [purple, pink],
    begin: Alignment(-0.5, -1),
    end: Alignment(0.5, 3.5),
  ),
);
