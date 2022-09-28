import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'package:auction/team_screen.dart';
import 'package:http/http.dart' as http;

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

List unSold = [
  'https://c.tenor.com/ucH_57n_at4AAAAM/froggiestoken-froggiescoin.gif',
  'https://c.tenor.com/nfrPVOQcS_4AAAAC/friends.gif',
  'https://c.tenor.com/do8q_eYrsW4AAAAM/crying-black-guy-meme.gif',
];
List sold = [
  'https://c.tenor.com/9xx5jJaHPpIAAAAd/fat-guy.gif',
  'https://c.tenor.com/baH5EAJ8upIAAAAM/sold-happy.gif',
  'https://c.tenor.com/cuC38NE_ynAAAAAM/dog-cute.gif',
  'https://media0.giphy.com/media/Jzxgefavt2aB2/200.gif',
  'https://media1.giphy.com/media/SsIPF2HnLYlQnFGKsZ/200w.gif?cid=82a1493bfnzjv4e1ujkpouysxl1tzdldjrit8soeqbasur6i&rid=200w.gif&ct=g',
];

class _ViewOnlyScreenState extends State<ViewOnlyScreen>
    with TickerProviderStateMixin {
  List unsoldMusic = [
    'bewafa',
    'thukra',
  ];

  var dataInJson = {
    'name': 'Atharva',
    'price': 10,
    'image': 'http://172.105.41.217:8000/get-image/atharva_dalal',
    'bid_by': null,
  };

  var bidedPlayer = {};

  @override
  void initState() {
    viewChannel = WebSocketChannel.connect(
      Uri.parse('ws://172.105.41.217:8000/ws/view-only'),
    );
    http.get(
      Uri.parse('http://172.105.41.217:8000/start-aution'),
    );
    viewChannel.sink.add(jsonEncode({'event': 'start_auction'}));

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
                'name': 'Atharva',
                'price': 10,
                'image': 'http://172.105.41.217:8000/get-image/atharva_dalal',
                'bid_by': null,
              }
            : jsonDecode(data);
      });

      if (data == '{"event": "end_auction"}') {
        viewChannel.sink.close();
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TeamScreen()));
        timer.cancel();
      }
    });
    // TODO: implement initState
    startTimer() {
      const oneSec = const Duration(seconds: 1);
      timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (start == 0) {
            setState(() {
              bidedPlayer = dataInJson;

              start = 7;
              if (dataInJson['bid_by'] == null) {
                AudioPlayer player = AudioPlayer();
                player.play(
                  // AssetSource(unsoldMusic[Random().nextInt(1)]),
                  UrlSource(
                      'http://172.105.41.217:8000/download/player_unsold'),
                );
                Future.delayed(Duration(seconds: 7), () {
                  player.stop();
                  start = 30;
                  Navigator.pop(context);
                });

                setState(
                  () {
                    viewChannel.sink
                        .add(jsonEncode({'event': 'player_unsold'}));

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.network(
                                    unSold[Random().nextInt(sold.length)],
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                  ),
                                  Text(
                                    'Unsold',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    'Name:- ' + dataInJson['name'].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    'Price:- None',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    'Bid by:- None',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
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
                        return Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.network(
                                    sold[Random().nextInt(sold.length)],
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                  ),
                                  Text(
                                    'Sold',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    'Name:- ' + bidedPlayer['name'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    'Price:- ' +
                                        (bidedPlayer['price'] / 10).toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    'Bid by:- ' + bidedPlayer['bid_by'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
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
          Container(
            width: 400,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  dataInJson['image'].toString(),
                ),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity - 1,
            height: MediaQuery.of(context).size.height / 6,
            child: GestureDetector(
              onTap: () {
                print(sold[Random().nextInt(sold.length)]);
                print(Random().nextInt(sold.length));
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Bid By:- '.toUpperCase() +
                                      dataInJson['bid_by'].toString() ==
                                  'null' ||
                              dataInJson['bid_by'] == null
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
          ),
          SizedBox(
            width: double.infinity - 1,
            height: MediaQuery.of(context).size.height / 6,
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
    );
  }
}
