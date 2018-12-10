import 'package:flutter/material.dart';
import 'package:tictactoe_3d/game_screen.dart';

const String gameTitle = '\nWelcome to 3D Tic Tac Toe! \n\n';
const String gameHowTo =
    '3D Tic-Tac-Toe is an abstract strategy board game designed for two players. It is very similar to traditional tic-tac-toe. Players alternate turns placing their respective markers in clank cells through the array. Players will accumulate points for every winning combination until the board is completely filled. The player with the highest number of points at the end of the game wins.'
    '\n\n Team: Byte Me';

class MainScreen extends StatefulWidget {
  final String title;

  MainScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState(title);
  }
}

class _MainScreenState extends State<MainScreen> {
  final String title;

  _MainScreenState(this.title);

  Widget gamePicture(BuildContext context){
    return new Container(
      width: 125.0,
      height: 238.0,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage('https://i0.wp.com/www.thegamegal.com/wp-content/uploads/2010/08/tic-tac-toe-animation-medium.gif?ssl=1'
          ),
        ),
        ),
      );
  }

  Widget basicGameRules(BuildContext context) {
    return ListTile(
      title: Text('\nHow to Play :'),
      subtitle: Text(gameHowTo),
    );
  }

  Widget startGameButton(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: RaisedButton(
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => GameScreen());
          Navigator.of(context).push(route);
        },
        color: Colors.blue,
        textColor: Colors.white,
        padding: const EdgeInsets.all(9.0),
        child: Text(
          'Tap Here to Play',
          style: textTheme.display1,
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Center(child: Text(gameTitle, style: textTheme.title)),
        gamePicture(context),
        startGameButton(context),
        basicGameRules(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body(context),
    );
  }
}
