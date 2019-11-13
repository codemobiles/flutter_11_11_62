import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 50,
        ),
        itemBuilder: (context, index) => Text("aaa"),
        separatorBuilder: (context, _) => Divider(),
        itemCount: 20,
      ),
    );
  }
}
