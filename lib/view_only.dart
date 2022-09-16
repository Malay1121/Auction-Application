import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:auction/game_pin.dart';
import 'package:auction/waiting_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ViewOnlyScreen extends StatefulWidget {
  const ViewOnlyScreen({Key? key}) : super(key: key);

  @override
  State<ViewOnlyScreen> createState() => _ViewOnlyScreenState();
}

late Timer timer;
int start = 30;
bool bidEnd = false;
bool lessThanFive = false;

class _ViewOnlyScreenState extends State<ViewOnlyScreen>
    with TickerProviderStateMixin {
  List unsoldMusic = [
    'bewafa',
    'thukra',
  ];

  var dataInJson = {
    'name': 'Loading.... shaanti rakho',
    'price': 10,
    'bid_by': null,
  };

  @override
  void initState() {
    viewChannel = WebSocketChannel.connect(
      Uri.parse('ws://172.105.41.217:8000/ws/view-only'),
    );
    viewChannel.sink.add(jsonEncode({'event': 'start_auction'}));
    http.get(
      Uri.parse('http://172.105.41.217:8000/start-aution'),
    );
    viewChannel.stream.listen((event) {
      String data = event.toString();
      if (start <= 5) {
        setState(() {
          start = 5;
        });
      }
      setState(() {
        dataInJson = jsonDecode(data) == null
            ? {
                'name': 'Loading.... shaanti rakho',
                'price': 10,
                'bid_by': 'Not bidded yet!',
              }
            : jsonDecode(data);
      });
    });
    // TODO: implement initState
    void startTimer() {
      const oneSec = const Duration(seconds: 1);
      timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (start == 0) {
            setState(() {
              start = 7;
              if (dataInJson['bid_by'] == null) {
                AudioPlayer player = AudioPlayer();
                player.play(
                  // AssetSource(unsoldMusic[Random().nextInt(1)]),
                  UrlSource(
                      "http://172.105.41.217:8000/download/player_unsold"),
                );
                Future.delayed(Duration(seconds: 7), () {
                  player.stop();
                  start = 30;
                  Navigator.pop(context);
                });

                setState(() {
                  viewChannel.sink.add(jsonEncode({'event': 'player_unsold'}));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            children: [
                              Image.network(
                                  'https://c.tenor.com/do8q_eYrsW4AAAAC/crying-black-guy-meme.gif'),
                              Text('Unsold :('),
                            ],
                          ),
                        );
                      });
                });
              }
              if (dataInJson['bid_by'] != null) {
                AudioPlayer player = AudioPlayer();
                player.play(
                  // AssetSource(unsoldMusic[Random().nextInt(1)]),
                  UrlSource("http://172.105.41.217:8000/download/player_sold"),
                );
                Future.delayed(Duration(seconds: 7), () {
                  player.stop();
                  start = 30;
                  Navigator.pop(context);
                });
                setState(() {
                  viewChannel.sink.add(jsonEncode({
                    "event": "player_sold",
                    "para": {"sold_to": dataInJson['bid_by']}
                  }));
                  viewChannel.sink.add(
                    jsonEncode(
                      {
                        'event': 'update_money',
                        'para': {
                          'mentor': dataInJson['bid_by'],
                        },
                      },
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            children: [
                              Image.network(
                                  'https://c.tenor.com/9xx5jJaHPpIAAAAd/fat-guy.gif'),
                              Text('Sold'),
                            ],
                          ),
                        );
                      });
                });
              }
            });
          } else {
            setState(() {
              start--;
            });
          }

          if (start <= 5) {
            setState(() {
              lessThanFive = true;
            });
          }
        },
      );
    }

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(70, 23, 143, 1),
      body: ListView(
        children: [
          // StreamBuilder(
          //   stream: channel.stream,
          //   builder: ((context, snapshot) {
          //     String data = snapshot.data.toString();
          //     Map dataInJson = jsonDecode(data) == nullz
          //         ? {
          //             'name': 'Loading.... shaanti rakho',
          //             'price': 10,
          //             'bid_by': 'Not bidded yet!',
          //           }
          //         : jsonDecode(data);
          //     return
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 10,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Center(
                        child: Text(
                          dataInJson['name'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '00:$start',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 1.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img1.hscicdn.com/image/upload/f_auto/lsci/db/PICTURES/CMS/305600/305646.3.jpg',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity - 1,
                height: MediaQuery.of(context).size.height / 7,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Bid By:- '.toUpperCase() +
                                    dataInJson['bid_by'].toString() ==
                                'null'
                            ? 'Not bidded yet!'
                            : dataInJson['bid_by'].toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity - 1,
                height: MediaQuery.of(context).size.height / 7,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Price:- '.toUpperCase() +
                            '${int.parse(dataInJson['price'].toString()) / 10} CR',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ),
        ],
      ),
    );
  }
}
