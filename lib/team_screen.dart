import 'dart:convert';

import 'package:auction/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key, this.name}) : super(key: key);

  final String? name;

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

Map teamData = jsonDecode(
  jsonEncode(
    {
      'teams': [
        {
          'ayuu': [
            {
              'name': 'Malay Patel',
              'image':
                  'https://media-exp1.licdn.com/dms/image/C4D03AQHIDwoa53KArQ/profile-displayphoto-shrink_800_800/0/1640676164585?e=1668038400&v=beta&t=o8EESGzp2SPGUK55LD63IBaLOUiX37cGis7PzZOauPk',
              'price': 10,
              'bid_by': null,
              'sold_to': "view"
            },
          ]
        },
        {
          'view': [
            {
              'name': 'Malay Patel',
              'image':
                  'https://media-exp1.licdn.com/dms/image/C4D03AQHIDwoa53KArQ/profile-displayphoto-shrink_800_800/0/1640676164585?e=1668038400&v=beta&t=o8EESGzp2SPGUK55LD63IBaLOUiX37cGis7PzZOauPk',
              'price': 10,
              'bid_by': null,
              'sold_to': 'view'
            },
            {
              'name': "Uvesh Rajwani",
              'image':
                  'https://media-exp1.licdn.com/dms/image/C4D03AQHIDwoa53KArQ/profile-displayphoto-shrink_800_800/0/1640676164585?e=1668038400&v=beta&t=o8EESGzp2SPGUK55LD63IBaLOUiX37cGis7PzZOauPk',
              'price': 10,
              'bid_by': null,
              'sold_to': 'view'
            }
          ]
        },
        {
          'unsold': [
            {
              'name': 'Malay Patel',
              'image':
                  'https://media-exp1.licdn.com/dms/image/C4D03AQHIDwoa53KArQ/profile-displayphoto-shrink_800_800/0/1640676164585?e=1668038400&v=beta&t=o8EESGzp2SPGUK55LD63IBaLOUiX37cGis7PzZOauPk',
              'price': 10,
              'bid_by': null,
              'sold_to': 'view'
            },
          ]
        }
      ]
    },
  ),
);

class _TeamScreenState extends State<TeamScreen> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    getreq() async {
      var getReq = await http.get(
        Uri.parse('http://172.105.41.217:8000/show_teams'),
      );
      setState(() {
        teamData = jsonDecode(getReq.body);
      });
    }

    getreq();
    return Scaffold(
      backgroundColor: Color.fromRGBO(70, 23, 143, 1),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              viewChannel.sink.add(jsonEncode({"event": "show_teams"}));
            },
            child: Text('get'),
          ),
          for (Map team in teamData['teams'])
            for (var key in team.keys)
              Container(
                width: MediaQuery.of(context).size.width / 6 - 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      key.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                    Divider(),
                    for (var mentees in team[key])
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mentees['name'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            mentees['price'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
