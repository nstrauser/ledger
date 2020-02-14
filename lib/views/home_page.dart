import 'package:flutter/material.dart';
import '../models/bill.dart';
import 'details_page.dart';
import '../shared/theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Bill> billList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bills', style: Theme.of(context).textTheme.headline1),
        elevation: 12,
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: kBackgroundColor,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/details");
          },
      backgroundColor: kBrickRed,
      child: Icon(Icons.add, size: 34),
        hoverColor: kBrickRedDarker,
      ),
      body: SafeArea(child: _body()),
    );
  }
  Widget _body() {
    return Container(child: ListView.builder(itemCount: count, itemBuilder: (BuildContext context, int index) {
      return Card(
        color: kBackgroundDarker,
        elevation: 2.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: kBrickRed,
            child: Text('A'),
          ),
          title: Text(this.billList[index].title, style: Theme.of(context).textTheme.headline2),
        ),
      );
    }, ),);
  }
}

