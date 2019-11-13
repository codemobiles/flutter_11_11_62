import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class NetWorkService {
  static Future<String> upload(File imageFile) async {
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
        'userfile', // key server
        stream,
        length,
        filename: basename(imageFile.path), // file name
        contentType: MediaType('image', 'png'), // media type
      );

      var uri = Uri.parse('http://192.168.0.102:1112/uploads');
      var request = http.MultipartRequest("POST", uri);
      request.files.add(multipartFile);

      //optional
      request.fields['date'] = '30/20/25';
      request.fields['comment'] = 'i love flutter';

      var response = await request.send();

      if (response.statusCode == 200) {
        String result;

        await response.stream.transform(utf8.decoder).listen((value) {
          result = value;
        }).asFuture();

        return result;
      } else {
        return "Failed to upload";
      }
    } catch (ex) {
      return ex.toString();
    }
  }
}
