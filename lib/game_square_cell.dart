import 'package:flutter/material.dart';
import 'package:tictactoe_3d/model.dart';

class GameSquareCell extends StatelessWidget {
  final GameSquare square;
  final GameBoard board;
  final VoidCallback callback;

  const GameSquareCell(this.board, this.square, this.callback, {Key key})
      : super(key: key);

  Widget squareValue(BuildContext context) {
    Widget innerWidget;
    TextTheme textTheme = Theme.of(context).textTheme;
    switch (square.value) {
      case Type.X:
        innerWidget = Text('X', style: textTheme.display1);
        break;
      case Type.O:
        innerWidget = Text('O', style: textTheme.display1);
        break;
      case Type.NotSet:
        innerWidget = Container(
          width: 0.0,
          height: 0.0,
        );
        break;
    }
    return innerWidget;
  }

  Widget boxWithValue(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          color: Colors.blueAccent,
        ),
        squareValue(context),
      ],
    );
  }

  void onTap() {
    if (square.value != Type.NotSet) {
      print("Square's value is set to: ${square.value}, let's do nothing!");
      return null;
    }

    if (board.gameOn == false) {
      print("Game has not started yet. So let's do nothing");
      return null;
    }

    Player currentPlayer = board.current();
    Type newValue;
    if (currentPlayer.playerType == Type.O) {
      newValue = Type.O;
    } else {
      newValue = Type.X;
    }
    square.value = newValue;
    board.switchTurn();
    board.calculateScore(currentPlayer);

    callback();
  }

  Widget boardBox(BuildContext context) {
    return InkWell(
      child: boxWithValue(context),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return boardBox(context);
  }
}
