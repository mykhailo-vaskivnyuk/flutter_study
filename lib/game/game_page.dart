import 'package:flutter/material.dart';
import 'package:flutter_app_first/game/game.dart';
import 'package:flutter_app_first/game/guess_input.dart';
import 'package:flutter_app_first/game/tile.dart';

class GamePage extends StatefulWidget {
  GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 5.0,
        children: [
          ..._game.guesses.map(
            (guess) => Row(
              spacing: 5.0,
              children: [
                for (final letter in guess) Tile(letter.char, letter.type),
              ],
            ),
          ),
          GuessInput(onSubmitGuess: (String guess) {
              setState(() { 
                _game.guess(guess);
              });
            },),
        ],
      ),
    );
  }
}
