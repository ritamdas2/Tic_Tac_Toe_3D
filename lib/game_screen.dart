import 'package:flutter/material.dart';
import 'package:tictactoe_3d/game_square_cell.dart';
import 'package:tictactoe_3d/model.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  bool gamePaused = false;

  GameBoard board;

  @override
  initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    board = GameBoard();
    board.gameOn = true;
    gamePaused = false;
  }

  Widget buttonText(BuildContext context) {
    String text;
    if (board.gameDone == true) {
      text = 'Reset';
    } else if (board.gameOn == true && gamePaused == false) {
      text = 'Pause';
    } else if (board.gameOn == true && gamePaused == true) {
      text = 'Resume';
    } else {
      text = 'Start';
    }
    return Text(
      text,
      style: TextStyle(color: Colors.white),
    );
  }

  void onAction() {
    if (board.gameDone) {
      setState(() {
        startGame();
      });
      return null;
    }

    if (board.gameOn == true) {
      setState(() {
        gamePaused = !gamePaused;
      });
    } else {
      setState(() {
        board.gameOn = true;
      });
    }
  }

  void callbackFunction() {
    setState(() {});
  }

  Widget level(BuildContext context, List<List<GameSquare>> level) {
//    [
//      Row(GameSquare()--8.0--GameSquare()--8.0--GameSquare()),
//                  |
//                  8.0
//                  |
//      Row(GameSquare()--8.0--GameSquare()--8.0--GameSquare()),
//                  |
//                  8.0
//                  |
//      Row(GameSquare()--8.0--GameSquare()--8.0--GameSquare()),
//                  |
//                  8.0
//                  |
//    ]

    List<Widget> rows = [];

    for (var row in level) {
      List<Widget> rowWidgets = [];

      for (var square in row) {
        Widget colWidget = GameSquareCell(board, square, callbackFunction);
        rowWidgets.add(colWidget);
      }

      Widget wrappedRow = Wrap(
        direction: Axis.horizontal,
        spacing: 2.0,
        children: rowWidgets,
      );
      rows.add(wrappedRow);
    }

    Widget wrappedColumn = Wrap(
      direction: Axis.vertical,
      spacing: 1.5,
      children: rows,
    );

    return ListTile(title: wrappedColumn);
  }

  Widget gameDetails(BuildContext context) {
    Widget subTitle = Wrap(
      direction: Axis.horizontal,
      spacing: 8.0,
      children: <Widget>[
        Text('${board.players[0]}: ${board.players[0].score} points'),
        Text('${board.players[1]}: ${board.players[1].score} points'),
      ],
    );

    return ListTile(
      title: Center(child: Text("${board.current()}'s turn")),
      subtitle: Center(child: subTitle),
    );
  }

  Widget gameResult(BuildContext context) {
    if (board.gameDone == false) {
      return Center(
        child: FlatButton(
            onPressed: () {
              board.gameDone = true;
              onAction();
            },
            child: Text('Clear')),
      );

     // return Container(height: 0.0, width: 0.0);
    }

    String title;
    Player winner = board.winner;
    if (winner == null) {
      title = 'The game is a TIE! @ ${board.players[0].score} points';
    } else {
      title = 'Congratulations $winner (${winner.score} points)';
    }

    return ListTile(
      title: Center(
        child: Text(title),
      ),
    );
  }

  Widget body(BuildContext context) {
    const double widthOfOneStep = 118.0; // bonus points for figuring out how

    return Column(
      children: <Widget>[
        gameDetails(context),
        Divider(),
        level(context, board.top),
        Divider(),
        Padding(
          padding: EdgeInsets.only(left: widthOfOneStep),
          child: level(context, board.middle),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.only(left: widthOfOneStep * 2),
          child: level(context, board.bottom),
        ),
        Divider(),
        gameResult(context),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D TicTacToe'),
        actions: <Widget>[
          FlatButton(
            child: buttonText(context),
            onPressed: onAction,
          )
        ],
      ),
      body: body(context),
    );
  }
}
