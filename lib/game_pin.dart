import 'dart:ui';

import 'package:flutter/material.dart';

class GamePin extends StatefulWidget {
  const GamePin({Key? key}) : super(key: key);

  @override
  State<GamePin> createState() => _GamePinState();
}

class _GamePinState extends State<GamePin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Color.fromRGBO(70, 23, 143, 1),
            child: Center(
              child: SizedBox(
                height: 130,
                width: 300,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                          scrollPadding: EdgeInsets.zero,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCCCCCC),
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCCCCCC),
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCCCCCC),
                                width: 2,
                              ),
                            ),
                            hintText: 'Game PIN',
                            hintStyle: TextStyle(
                              color: Color(0xFFB2B2B2),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GamePin2()));
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFF2F2F2F),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Enter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GamePin2 extends StatefulWidget {
  const GamePin2({Key? key}) : super(key: key);

  @override
  State<GamePin2> createState() => _GamePin2State();
}

class _GamePin2State extends State<GamePin2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Color.fromRGBO(70, 23, 143, 1),
            child: Center(
              child: SizedBox(
                height: 130,
                width: 300,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                          scrollPadding: EdgeInsets.zero,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCCCCCC),
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCCCCCC),
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCCCCCC),
                                width: 2,
                              ),
                            ),
                            hintText: 'Nickname',
                            hintStyle: TextStyle(
                              color: Color(0xFFB2B2B2),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GamePinWaiting()));
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFF2F2F2F),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Enter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GamePinWaiting extends StatefulWidget {
  const GamePinWaiting({Key? key}) : super(key: key);

  @override
  State<GamePinWaiting> createState() => _GamePinWaitingState();
}

class _GamePinWaitingState extends State<GamePinWaiting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Color.fromRGBO(70, 23, 143, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You\'re in!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'See your nickname on screen?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 35.0),
                  child: Text(
                    'Player 1',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
