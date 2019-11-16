import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/bloc/authen/bloc.dart';
import 'package:my_app/src/global_variable.dart';
import 'package:my_app/src/models/youtube_response.dart';
import 'package:my_app/src/services/auth_service.dart';
import 'package:my_app/src/services/network_service.dart';
import 'package:my_app/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
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
                    padding: EdgeInsets.only(bottom: 50),
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

  _buildHeader({@required Youtube item}) {
    var isFavorite = false;
    GlobalVariable.favoriteList.forEach((data) {
      if (item.id == data.id) {
        isFavorite = true;
      }
    });

    return ListTile(
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
        icon: isFavorite
            ? Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : Icon(Icons.favorite_border),
        onPressed: () {
          var isItem = false;
          var index = 0;

          GlobalVariable.favoriteList.asMap().forEach((_index, data) {
            if (data.id == item.id) {
              isItem = true;
              index = _index;
            }
          });

          if (isItem == true) {
            GlobalVariable.favoriteList.removeAt(index);
          } else {
            GlobalVariable.favoriteList.add(item);
          }

          setState(() {});
        },
      ),
    );
  }

  _buildBody({Youtube item}) => GestureDetector(
        onTap: () {
          // deep link youtube
          _launchURL(item.id);
        },
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: item.youtubeImage,
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
          fadeInDuration: Duration(seconds: 1),
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
//        floating: true,
//        snap: true,
//        pinned: true,
        title: Text("CodeMobiles Flutter"),
        backgroundColor: Colors.blue,
        expandedHeight: 200,
        flexibleSpace: FlexibleSpaceBar(
          title: Text("Marvel Lover"),
          centerTitle: true,
          collapseMode: CollapseMode.parallax,
          background: Image.network(
            "https://ichef.bbci.co.uk/news/410/cpsprodpb/BF0D/production/_106090984_2e39b218-c369-452e-b5be-d2476f9d8728.jpg",
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, Constant.FAVORITE_ROUTE);
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: showDialogConfirm,
          )
        ],
      );

  Future<void> showDialogConfirm() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Title"),
          content: Text("Are you sure?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
//                Navigator.pushNamedAndRemoveUntil(context, Constant.LOGIN_ROUTE,
//                    (Route<dynamic> route) => false);
//
//                AuthService().logout();
                Navigator.pop(context);
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
              child: Text(
                "Yes",
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "No",
              ),
            )
          ],
        );
      },
    );
  }
}
