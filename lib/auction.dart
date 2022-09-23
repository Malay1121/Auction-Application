import 'dart:async';
import 'dart:convert';

import 'package:auction/create_auction.dart';
import 'package:auction/game_pin.dart';
import 'package:auction/team_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

String moneyData = '{"money":600}';

class _AuctionScreenState extends State<AuctionScreen> {
  @override
  void initState() {
    // TODO: implement initState

    mentorChannel = WebSocketChannel.connect(
        Uri.parse('ws://172.105.41.217:8000/ws/${widget.name}'));
    mentorChannel.stream.listen((event) async {
      setState(() {
        String finalData = event.toString();

        moneyData = finalData.toString();
      });
      if (moneyData == '{"event": "end_auction"}') {
        var getReq = await http.get(
          Uri.parse('http://172.105.41.217:8000/show_teams'),
        );
        setState(() {
          teamData = jsonDecode(getReq.body);
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text('See your team on the screen!'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    moneyData = moneyData.replaceAll(RegExp(r'^[\{\}]', unicode: true), "");

    moneyData = moneyData.substring(8, moneyData.length - 1);
    var inInt = (double.parse(moneyData) / 10).toString();
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
                      'Money:- ' + (inInt).toString() + ' cr',
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
              },
              child: Card(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '10 Lakhs',
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
              },
              child: Card(
                color: Colors.red,
                child: Center(
                  child: Text(
                    '20 Lakhs',
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
