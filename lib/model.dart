enum Type { NotSet, X, O }

class GameSquare {
  Type value;

  GameSquare() {
    // constructor
    value = Type.NotSet;
  }

  @override
  String toString() {
    String stringValue;
    switch (value) {
      case Type.NotSet:
        stringValue = 'B';
        break;
      case Type.O:
        stringValue = 'O';
        break;
      case Type.X:
        stringValue = 'X';
        break;
    }
    return stringValue;
  }
}

class GameBoard {
  bool gameOn = false;
  bool gameDone = false;

  Player get winner {
    if (gameDone == false) {
      return null;
    }

    if (players[0].score == players[1].score) {
      return null;
    }

    if (players[0].score > players[1].score) {
      return players[0];
    }
    return players[1];
  }

  int playerTurn = 0;

  List<Player> players = [
    Player(Type.O),
    Player(Type.X),
  ];

  // You could design this generally as a List<List<List<GameBoard>>> but
  // that is pointless, since a 3D TTT can only have 3 levels
  List<List<GameSquare>> top = [
    [GameSquare(), GameSquare(), GameSquare()],
    [GameSquare(), GameSquare(), GameSquare()],
    [GameSquare(), GameSquare(), GameSquare()],
  ];
  List<List<GameSquare>> middle = [
    [GameSquare(), GameSquare(), GameSquare()],
    [GameSquare(), GameSquare(), GameSquare()],
    [GameSquare(), GameSquare(), GameSquare()],
  ];
  List<List<GameSquare>> bottom = [
    [GameSquare(), GameSquare(), GameSquare()],
    [GameSquare(), GameSquare(), GameSquare()],
    [GameSquare(), GameSquare(), GameSquare()],
  ];

  void setGameStatus() {
    for (var level in getLevels()) {
      for (var row in level) {
        for (var square in row) {
          if (square.value == Type.NotSet) {
            return null;
          }
        }
      }
    }
    gameDone = true;
  }

  void printMatrix(List<List<GameSquare>> matrix, String axis) {
    print('--------$axis----------');
    String m = '\n';
    for (var row in matrix) {
      String r = '';
      for (var col in row) {
        r += '\t' + col.toString();
      }
      m += r + '\n';
    }
    m += '\n';
    print(m);
  }

  void calculateScore(Player player) {
    // calculate score for each player.
    int playerScore = 0;

    var levels = getLevels();

    // Z axis
    for (List<List<GameSquare>> level in levels) {
      printMatrix(level, 'Z');

      playerScore += horizontalScore(level, player.playerType);
      playerScore += verticalScore(level, player.playerType);
      playerScore += diagonalScore(level, player.playerType);
    }

    // Y axis
    for (int index = 0; index < 3; index++) {
      List<List<GameSquare>> yAxisRows = [];
      for (var level in levels) {
        List<GameSquare> yAxisRow = [];
        for (var row in level) {
          yAxisRow.add(row[index]);
        }
        yAxisRows.add(yAxisRow);
      }
      printMatrix(yAxisRows, 'Y');
      // 3 x 3 matrix in Y axis
      playerScore += horizontalScore(yAxisRows, player.playerType);
      playerScore += verticalScore(yAxisRows, player.playerType);
      playerScore += diagonalScore(yAxisRows, player.playerType);
    }

    // X axis
    for (int index = 0; index < 3; index++) {
      List<List<GameSquare>> xAxisRows = [];
      for (var level in levels) {
        xAxisRows.add(level[index]);
      }
      printMatrix(xAxisRows, 'X');

      // 3 x 3 matrix in x axis
      playerScore += horizontalScore(xAxisRows, player.playerType);
      playerScore += verticalScore(xAxisRows, player.playerType);
      playerScore += diagonalScore(xAxisRows, player.playerType);
    }

    // diagonal (back to front)
    List<List<GameSquare>> backToFront = [];
    backToFront.add(levels[0][0]);
    backToFront.add(levels[1][1]);
    backToFront.add(levels[2][2]);
    printMatrix(backToFront, 'BackToFront');
    // 3 x 3 matrix in diagonal (back to front)
    //playerScore += horizontalScore(backToFront, player.playerType);
    //playerScore += verticalScore(backToFront, player.playerType);
    //playerScore += diagonalScore(backToFront, player.playerType);

    // diagonal (front to back)
    List<List<GameSquare>> frontToBack = [];
    frontToBack.add(levels[2][2]);
    frontToBack.add(levels[1][1]);
    frontToBack.add(levels[0][0]);
    printMatrix(frontToBack, 'FrontToBack');
    // 3 x 3 matrix in diagonal (front to back)
   // playerScore += horizontalScore(frontToBack, player.playerType);
    //playerScore += verticalScore(frontToBack, player.playerType);
    playerScore += diagonalScore(frontToBack, player.playerType);

    player.score = playerScore;
    setGameStatus();
  }

  List<List<List<GameSquare>>> getLevels() {
    return [
      top,
      middle,
      bottom,
    ];
  }

  int horizontalScore(List<List<GameSquare>> rows, Type playerType) {
    int score = 0;

    for (var row in rows) {
      if (row[0].value != playerType) {
        continue;
      }
      if ((row[0].value == row[1].value) && (row[0].value == row[2].value)) {
        score++;
      }
    }
    return score;
  }

  int verticalScore(List<List<GameSquare>> rows, Type playerType) {
    int score = 0;
    for (int index = 0; index < rows[0].length; index++) {
      // 0, 1, 2
      Type anchorValue = rows[0][index].value;
      if (anchorValue != playerType) {
        continue;
      }

      if ((anchorValue == rows[1][index].value) &&
          (anchorValue == rows[2][index].value)) {
        score++;
      }
    }
    return score;
  }

  int diagonalScore(List<List<GameSquare>> rows, Type playerType) {
    int score = 0;

    Type anchorValue = rows[1][1].value;
    if (anchorValue != playerType) {
      return score;
    }

    if ((anchorValue == rows[0][0].value) &&
        (anchorValue == rows[2][2].value)) {
      score++;
    }

    if ((anchorValue == rows[0][2].value) &&
        (anchorValue == rows[2][0].value)) {
      score++;
    }
    return score;
  }

  Player current() {
    return players[playerTurn];
  }

  Player switchTurn() {
    if (playerTurn == 0) {
      playerTurn = 1;
    } else if (playerTurn == 1) {
      playerTurn = 0;
    }
    return players[playerTurn];
  }
}

class Player {
  Type playerType;
  int score;

  Player(Type type) {
    // constructor
    this.playerType = type;
    this.score = 0;
  }

  @override
  String toString() {
    if (playerType == Type.O) {
      return 'Player: O';
    } else {
      return 'Player: X';
    }
  }
}
