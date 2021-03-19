import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import 'constant.dart';


class Body extends StatelessWidget {
  String item;
  Body(this.item);
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Collections",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold,color: Colors.black),
            ),
          ),

          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(item)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();

                      var categories = snapshot.data.documents;
                      return Expanded(
                        child: GridView.builder(
                          itemCount: categories.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: kDefaultPaddin,
                            crossAxisSpacing: kDefaultPaddin,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (context, index) =>
                              buildItem(categories[index], index),

                          /* press: () => Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => DetailsScreen(
      product: categories[index],
      ),
      )*/
                        ),
                      );
                    }
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(DocumentSnapshot document, int index) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            document.data()['image'],
            height: 50,
            width: 50,
          ),
          Text(
            document.data()['name'],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.purple),
          ),
          Text(
              document.data()['price'].toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color:Colors.black )
          ),
        ],
      ),
    );
  }
}
