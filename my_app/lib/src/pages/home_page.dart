import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var item = [11, 22, 33, 44];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                _buildHeader(),
                _buildBody(),
                _buildFooter(),
              ],
            ),
          );
        },
        itemCount: item.length,
      ),
    );
  }

  _buildHeader() => ListTile(
//        leading: CircleAvatar(
//          child: ClipRRect(
//            borderRadius: BorderRadius.circular(45),
//            child: Image.network(
//              "https://sm.mashable.com/t/mashable_sea/feature/e/everything/everything-you-need-to-know-about-captain-marvels-cat_hgyd.910.jpg",
//              fit: BoxFit.cover,
//            ),
//          ),
//        ),
        leading: ClipOval(
          child: Image.network(
            "https://sm.mashable.com/t/mashable_sea/feature/e/everything/everything-you-need-to-know-about-captain-marvels-cat_hgyd.910.jpg",
            fit: BoxFit.cover,
            height: 45,
            width: 45,
          ),
        ),
        title: Text("Title"),
        subtitle: Text("SubTitle"),
        trailing: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {},
        ),
      );

  _buildBody() => Image.network(
      "https://sm.mashable.com/t/mashable_sea/feature/e/everything/everything-you-need-to-know-about-captain-marvels-cat_hgyd.910.jpg");

  _buildFooter() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.thumb_up),
            label: Text("Like"),
            onPressed: () {},
          ),
          SizedBox(width: 4),
          FlatButton.icon(
            icon: Icon(Icons.share),
            label: Text("Share"),
            onPressed: () {},
          ),
        ],
      );
}
