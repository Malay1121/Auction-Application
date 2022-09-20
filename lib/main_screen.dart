import 'package:auction/auction.dart';
import 'package:auction/create_auction.dart';
import 'package:auction/game_pin.dart';
import 'package:auction/team_screen.dart';
import 'package:auction/view_only.dart';
import 'package:auction/waiting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Text('Waiting screen'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WaitingScreen()));
          },
        ),
        GestureDetector(
          child: Text('View only screen'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewOnlyScreen()));
          },
        ),
        GestureDetector(
          child: Text('Game Pin'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => GamePin2()));
          },
        ),
        GestureDetector(
          child: Text('Create Auction'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateAuction()));
          },
        ),
      ],
    );
  }
}
