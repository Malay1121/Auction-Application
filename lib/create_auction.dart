import 'package:auction/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextEditingController priceController = TextEditingController(text: '1000000');
TextEditingController nameController = TextEditingController();
TextEditingController imageController = TextEditingController();

class CreateAuction extends StatefulWidget {
  const CreateAuction({Key? key}) : super(key: key);

  @override
  State<CreateAuction> createState() => _CreateAuctionState();
}

List _auction = [
  {
    'name': 'Malay Patel',
    'image':
        'https://media-exp1.licdn.com/dms/image/C4D03AQHIDwoa53KArQ/profile-displayphoto-shrink_800_800/0/1640676164585?e=1668038400&v=beta&t=o8EESGzp2SPGUK55LD63IBaLOUiX37cGis7PzZOauPk',
    'start': 10000000,
  },
  {
    'name': 'Uvesh Rajwani',
    'image':
        'https://media-exp1.licdn.com/dms/image/C4D03AQHIDwoa53KArQ/profile-displayphoto-shrink_800_800/0/1640676164585?e=1668038400&v=beta&t=o8EESGzp2SPGUK55LD63IBaLOUiX37cGis7PzZOauPk',
    'start': 150,
  },
  {
    'name': 'Vivaana Batki',
    'image':
        'https://media-exp1.licdn.com/dms/image/C4D03AQHIDwoa53KArQ/profile-displayphoto-shrink_800_800/0/1640676164585?e=1668038400&v=beta&t=o8EESGzp2SPGUK55LD63IBaLOUiX37cGis7PzZOauPk',
    'start': 1000000000000000000,
  },
];

class _CreateAuctionState extends State<CreateAuction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _auction.add({
                    'name': nameController.text,
                    'image': imageController.text,
                    'start': int.parse(priceController.text),
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
          for (var auction in _auction)
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
                          auction['image'],
                        ),
                      ),
                      Text(
                        auction['name'],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Starting price:- ${auction['start']}',
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