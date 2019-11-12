import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_app/src/models/youtube_response.dart';
import 'package:my_app/src/services/network_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var item = [11, 22, 33, 44];

  var _keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
//    NetworkService.getYoutube();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      // sliver
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            appBarSliver(),
          ];
        },
        body: FutureBuilder(
          future: NetworkService.getYoutube(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return RefreshIndicator(
                  key: _keyRefresh,
                  onRefresh: _refreshing,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final Youtube youtube = snapshot.data[index];

                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            _buildHeader(item: youtube),
                            _buildBody(item: youtube),
                            _buildFooter(item: youtube),
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                );
              } else {
                return Center(
                  child: Text('Network failure'),
                );
              }
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _buildHeader({@required Youtube item}) => ListTile(
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {},
        ),
      );

  _buildBody({Youtube item}) => GestureDetector(
        onTap: () {
          // deep link youtube
          _launchURL(item.id);
        },
        child: Image.network(
          item.youtubeImage,
          height: 250,
          fit: BoxFit.cover,
        ),
      );

  // singleton get_it
  _launchURL(String id) async {
    final url = 'https://www.youtube.com/watch?v=$id';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _buildFooter({Youtube item}) => Row(
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

  Future<void> _refreshing() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  appBarSliver() => SliverAppBar(
        title: Text("Title"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.print), onPressed: (){},)
        ],
      );
}
