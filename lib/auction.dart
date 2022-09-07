import 'package:flutter/material.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({Key? key}) : super(key: key);

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
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
            child: Center(
              child: Text(
                'Cricketer 1',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
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
                image: NetworkImage(
                  'https://img1.hscicdn.com/image/upload/f_auto/lsci/db/PICTURES/CMS/305600/305646.3.jpg',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Card(
              color: Colors.blue,
              child: Center(
                child: Text(
                  '10 lakhs',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              color: Colors.red,
              child: Center(
                child: Text(
                  '20 Lakh',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
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
