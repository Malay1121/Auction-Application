import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:auction/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';

TextEditingController priceController = TextEditingController(text: '1000000');
TextEditingController nameController = TextEditingController();
TextEditingController imageController = TextEditingController();

class CreateAuction extends StatefulWidget {
  const CreateAuction({Key? key}) : super(key: key);

  @override
  State<CreateAuction> createState() => _CreateAuctionState();
}

var auction = {
  'players_model': [
    {
      'name': 'Malay Patel',
      'image':
          'https://media-exp1.licdn.com/dms/image/C4D03AQHIDwoa53KArQ/profile-displayphoto-shrink_800_800/0/1640676164585?e=1668038400&v=beta&t=o8EESGzp2SPGUK55LD63IBaLOUiX37cGis7PzZOauPk',
      'price': 10,
    },
    {
      'name': 'Uvesh Rajwani',
      'image':
          'https://media-exp1.licdn.com/dms/image/C4D03AQHIDwoa53KArQ/profile-displayphoto-shrink_800_800/0/1640676164585?e=1668038400&v=beta&t=o8EESGzp2SPGUK55LD63IBaLOUiX37cGis7PzZOauPk',
      'price': 10,
    },
  ]
};

class _CreateAuctionState extends State<CreateAuction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WaitingScreen()));
              },
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  'Start Auction',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  auction['players_model']!.add({
                    'name': nameController.text,
                    'image': imageController.text,
                    'price': int.parse(priceController.text),
                  });
                });
              },
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  'Add Player',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                final response = await http.post(
                  Uri.parse('http://172.105.41.217:8000/add-auction'),
                  headers: {
                    'Content-Type': 'application/json',
                  },
                  body: jsonEncode(auction),
                );
                print(response.body);
                print(jsonEncode(auction));
              },
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: TextField(
                        controller: imageController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Image Link',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: TextField(
                        controller: nameController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Student Name',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: TextField(
                        controller: priceController,
                        maxLines: null,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          // for below version 2 use this
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: 'Starting Price',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          for (var auction in auction['players_model']!)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          auction['image'] as String,
                        ),
                      ),
                      Text(
                        auction['name'] as String,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Starting price:- ${auction['price']}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
