import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/model/game_model.dart';

import 'constants.dart';

class GameProvider extends ChangeNotifier {
  final player1 = [];
  final player2 = [];
  var activePlayer = 1;

  void playGame(GameModel gameModel, BuildContext context) {
    if (activePlayer == 1) {
      gameModel.text = 'X';
      gameModel.color = const Color.fromARGB(255, 217, 99, 99);
      activePlayer = 2;
      player1.add(gameModel.id);
      notifyListeners();
    } else {
      gameModel.text = '0';
      gameModel.color = Colors.greenAccent;
      activePlayer = 1;
      player2.add(gameModel.id);
      notifyListeners();
    }
    gameModel.enabled = false;
    int winner = checkWinner(context);
    if (winner == 0) {
      if (buttonList.every((element) => element.text != '')) {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            elevation: 0,
            title: Text('Game Tied'),
            content: Text('Press the reset button to start again'),
          ),
        );
      } else {
        activePlayer == 2 ? autoPlay(context) : null;
      }
    }
    notifyListeners();
  }

  int checkWinner(BuildContext context) {
    var winner = 0;
    //horizontal row 1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    // row2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    //row3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }
    // vertical column 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    // column 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }
    // column 3
    if (player1.contains(9) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(9) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }
    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }
    if (winner != 0) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  elevation: 0,
                  title: Text('Player 1 won!'),
                  content: Text('Press the reset button to start again'),
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  elevation: 0,
                  title: Text('Player 2 won!'),
                  content: Text('Press the reset button to start again'),
                ));
      }
    }
    return winner;
  }

  void resetGame(BuildContext context) {
    if (Navigator.canPop(context)) {
      return Navigator.pop(context);
    }
    buttonList.clear();
    player1.clear();
    player2.clear();
    activePlayer = 1;
    buttonList = init();

    notifyListeners();
  }

  Future<void> autoPlay(BuildContext context) async {
    final emptyCells = [];
    final list = List.generate(9, (index) => index + 1);
    await Future.delayed(const Duration(seconds: 1));

    for (var cellId in list) {
      if (!(player1.contains(cellId) || player2.contains(cellId))) {
        emptyCells.add(cellId);
      }
    }
    int randomCells;
    final random = Random();

    final List<int> cornerIndices = [0, 2, 4, 6];
    final List<int> corners =
        cornerIndices.map((index) => list[index]).toList();
    debugPrint('$corners');
    final List<int> edgeIndices = [1, 3, 5, 7, 8];
    final List<int> edge = edgeIndices.map((e) => list[e]).toList();
    debugPrint('$edge');
    if (emptyCells.isNotEmpty) {
      if (player1.isEmpty) {
        //player 1 starts at the centre
        randomCells = corners.indexOf(5);
      } else if (emptyCells.length == 1) {
        // one emptyCell remaining
        randomCells = 0;
      } else if (player1.length == 1) {
        // player 1 started at the corner
        randomCells = edge.indexOf(emptyCells.length);
      } else {
        //select a random cell
        randomCells = random.nextInt(emptyCells.length);
      }
      if (edge.contains(emptyCells[randomCells])) {
        // select an edge
        randomCells = edge.indexOf(emptyCells[randomCells]);
      } else {
        //select a random corner
        randomCells = corners.indexOf(emptyCells[randomCells]);
      }
    } else {
      // no empty cells
      return;
    }

    final i = list.indexOf(emptyCells[randomCells]);
    // ignore: use_build_context_synchronously
    playGame(buttonList[i], context);
  }
}
