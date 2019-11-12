import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/src/models/youtube_response.dart';

class NetworkService{

  static Future<void> getFakeJSON() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }


  static Future<List<Youtube>> getYoutube({String type = "superhero"}) async {
    var url = 'http://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=$type';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      YoutubeResponse youtube = YoutubeResponse.fromJson(jsonResponse);

      //youtube.youtubes.forEach((item) => print(item.title));

      await Future.delayed(Duration(seconds: 2));

      return youtube.youtubes;
    } else {
      throw Exception('Failed to load Youtubes');
    }
  }



}