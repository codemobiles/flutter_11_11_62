import 'package:flutter/material.dart';
import 'package:my_app/src/global_variable.dart';
import 'package:my_app/src/models/youtube_response.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite (${GlobalVariable.favoriteList.length})'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 50,
        ),
        itemBuilder: (context, index) {
          return _buildRow(item: GlobalVariable.favoriteList[index]);
        },
        separatorBuilder: (context, _) => Divider(),
        itemCount: GlobalVariable.favoriteList.length,
      ),
    );
  }

  _buildRow({@required Youtube item}) => ListTile(
        leading: ClipOval(
          child: Image.network(
            item.avatarImage,
            fit: BoxFit.cover,
            height: 45,
            width: 45,
          ),
        ),
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          item.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            GlobalVariable.favoriteList.removeWhere((data) {
              if (data.id == item.id) {
                return true;
              }
              return false;
            });

            setState(() {});
          },
        ),
      );
}
