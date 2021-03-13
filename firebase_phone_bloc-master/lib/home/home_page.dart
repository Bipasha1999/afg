import 'package:flutter/material.dart';

import '../login/login_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => LoginPage(),
        ),
        title: Text("Sample"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: Text("Yet to build home page")),
      ),
    );
  }
}
