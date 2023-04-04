import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider.dart';

import 'constants.dart';
import 'model/game_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tick tac toe'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: GameBoard(),
          ),
          Consumer<GameProvider>(builder: (context, game, _) {
            return GestureDetector(
              onTap: () {
                game.resetGame(context);
              },
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text('Reset'),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  const GameBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<GameProvider>(builder: (context, game, child) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: buttonList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    buttonList[index].enabled
                        ? game.playGame(buttonList[index], context)
                        : null;
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: buttonList[index].color,
                      border: Border.all(color: Colors.black, width: 5),
                    ),
                    child: Center(
                      child: Text(buttonList[index].text),
                    ),
                  ),
                );
              });
        }));
  }
}
