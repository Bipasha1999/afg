import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop/catagories.dart';
import 'body.dart';
import 'constant.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search)),
          IconButton(icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: Column(
        children: [
          buildCategorylist(context),
          Body(selectedCatagory),
        ],
      ),
    );
  }

  String selectedCatagory;
  int selectedIndex=0;

  @override
  Widget buildCategorylist(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('catagory').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('loading');
          var categories = snapshot.data.documents;
          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
              child: SizedBox(
                height: 25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) =>
                      buildCategory(categories[index], index),
                ),
              ),
            ),
          );
        });
  }

  Widget buildCategory(DocumentSnapshot document, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          selectedCatagory=document.data()['name'];
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              document.data()['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
