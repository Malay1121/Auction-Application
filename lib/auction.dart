import 'dart:async';
import 'dart:convert';

import 'package:auction/create_auction.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({Key? key}) : super(key: key);

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

late Timer _timer;
int _start = 30;
bool bidEnd = false;
bool lessThanFive = false;
int index = 0;
double totalMoney = 60;

class _AuctionScreenState extends State<AuctionScreen> {
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _start = 3;

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: Text('Sold'),
                  );
                });
            Future.delayed(Duration(seconds: 3), () {
              _start = 30;
              index = index + 1;
              Navigator.pop(context);
            });
          });
        } else {
          setState(() {
            _start--;
          });
        }
        if (_start <= 5) {
          setState(() {
            lessThanFive = true;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
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
                  Text(
                    '00:$_start',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          auction['players_model']![index]['name'] as String,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Price:- ' +
                              double.parse(auction['players_model']![index]
                                          ['start']
                                      .toString())
                                  .toStringAsFixed(1)
                                  .toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Text(
                      totalMoney.toStringAsFixed(1),
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
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height / 1.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(
                  auction['players_model']![index]['image'] as String,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final response = await http.post(
                  Uri.parse('https://dc6e-43-248-34-162.ngrok.io/new-bid'),
                  headers: {
                    'Content-Type': 'application/json',
                  },
                  body: jsonEncode({
                    'bidBy': 'Mohit',
                    'bidByMoney': 0.1,
                  }),
                );
                print(response.body);

                setState(() {
                  auction['players_model']![index]['start'] = double.parse(
                          auction['players_model']![index]['start']
                              .toString()) +
                      0.1;

                  lessThanFive == true ? _start = 5 : null;
                  totalMoney = totalMoney - 0.1;
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

                setState(() {
                  auction['players_model']![index]['start'] = double.parse(
                          auction['players_model']![index]['start']
                              .toString()) +
                      0.2;
                  totalMoney = totalMoney - 0.2;
                  lessThanFive == true ? _start = 5 : null;
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
