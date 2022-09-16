import 'dart:async';
import 'dart:convert';

import 'package:auction/create_auction.dart';
import 'package:auction/game_pin.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

bool bidEnd = false;
bool lessThanFive = false;
int index = 0;
double totalMoney = 60;
var moneyData = {'name': 'player', 'money': 600};

class _AuctionScreenState extends State<AuctionScreen> {
  @override
  void initState() {
    // TODO: implement initState

    mentorChannel = WebSocketChannel.connect(
        Uri.parse('ws://172.105.41.217:8000/ws/${widget.name}'));
    mentorChannel.stream.listen((event) {
      String data = event.toString();

      setState(() {
        moneyData = jsonDecode(data) == null
            ? {
                'name': 'Loading.... shaanti rakho',
                'price': 10,
                'bid_by': 'Not bidded yet!',
              }
            : jsonDecode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(70, 23, 143, 1),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 10,
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    child: Text(
                      'Money:- ' +
                          (int.parse(moneyData['money'].toString()) / 1)
                              .toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                // final response = await http.post(
                //   Uri.parse('https://dc6e-43-248-34-162.ngrok.io/new-bid'),
                //   headers: {
                //     'Content-Type': 'application/json',
                //   },
                //   body: jsonEncode({
                //     'bidBy': 'Mohit',
                //     'bidByMoney': 0.1,
                //   }),
                // );
                // print(response.body);
                mentorChannel.sink.add(jsonEncode({
                  'event': 'new_bid',
                  'para': {'price': 1, 'bid_by': widget.name}
                }));

                setState(() {
                  auction['players_model']![index]['start'] = double.parse(
                          auction['players_model']![index]['start']
                              .toString()) +
                      0.1;
                });
              },
              child: Card(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '0.1',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                // final response = await http.post(
                //   Uri.parse('https://dc6e-43-248-34-162.ngrok.io/new-bid'),
                //   headers: {
                //     'Content-Type': 'application/json',
                //   },
                //   body: jsonEncode({
                //     'bidBy': 'Mohit',
                //     'bidByMoney': 0.2,
                //   }),
                // );
                // print(response.body);

                mentorChannel.sink.add(jsonEncode({
                  'event': 'new_bid',
                  'para': {'price': 2, 'bid_by': widget.name}
                }));

                setState(() {
                  auction['players_model']![index]['start'] = double.parse(
                          auction['players_model']![index]['start']
                              .toString()) +
                      0.2;
                });
              },
              child: Card(
                color: Colors.red,
                child: Center(
                  child: Text(
                    '0.2',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
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
