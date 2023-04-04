import 'package:tic_tac_toe/model/game_model.dart';
import 'package:tic_tac_toe/provider.dart';

final game = GameProvider();
List<GameModel> buttonList = [];

List<GameModel> init() {
  game.player1;
  game.player2;
  game.activePlayer;
  final gameButtons = <GameModel>[
    GameModel(id: 1),
    GameModel(id: 2),
    GameModel(id: 3),
    GameModel(id: 4),
    GameModel(id: 5),
    GameModel(id: 6),
    GameModel(id: 7),
    GameModel(id: 8),
    GameModel(id: 9),
  ];
  buttonList = gameButtons;
  return gameButtons;
}
