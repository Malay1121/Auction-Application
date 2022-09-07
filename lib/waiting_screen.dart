import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

bool players = false;

final player = AudioPlayer();

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    player.play(
      UrlSource(
        'https://iringtones.net/wp-admin/audio-user/115669426580497490804/baby-shark.mp3',
      ),
    );
    player.onPlayerComplete.listen((event) {
      player.play(UrlSource(
          'https://iringtones.net/wp-admin/audio-user/115669426580497490804/baby-shark.mp3'));
    });
  }

  @override
  Widget build(BuildContext context) {
    var _play = false;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        player.onPlayerStateChanged.listen((PlayerState s) {
          if (s == PlayerState.playing) {
            player.pause();
          } else {
            player.resume();
          }
        });
      }),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF240C68),
              ),
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 5.5,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GAME PIN:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '502 059',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 100,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(70, 23, 143, 1),
                ),
                child: players == false
                    ? Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (players == true) {
                                players = false;
                              } else {
                                players = true;
                              }
                            });
                          },
                          child: Card(
                            color: Colors.black.withOpacity(0.5),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Waiting for players...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            child: Card(
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10),
                                  child: Text(
                                    'Player 1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: Card(
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10),
                                  child: Text(
                                    'Player 1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: Card(
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10),
                                  child: Text(
                                    'Player 1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
