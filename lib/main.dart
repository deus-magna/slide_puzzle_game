import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/app/app.dart';
import 'package:slide_puzzle_game/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
