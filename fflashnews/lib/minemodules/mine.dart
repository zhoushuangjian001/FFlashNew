import 'package:flutter/material.dart';

class MineRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
      ),
      body: Container(
        color: Colors.pinkAccent,
        child: Image.asset("assets/images/tabbar_images/tabbar_news_hl.png"),
      ),
    );
  }
}
