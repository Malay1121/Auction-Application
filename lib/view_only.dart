import 'package:flutter/material.dart';

class ViewOnlyScreen extends StatefulWidget {
  const ViewOnlyScreen({Key? key}) : super(key: key);

  @override
  State<ViewOnlyScreen> createState() => _ViewOnlyScreenState();
}

class _ViewOnlyScreenState extends State<ViewOnlyScreen> {
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
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Bid By:- Shees',
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Price:- 90 Lakhs',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
