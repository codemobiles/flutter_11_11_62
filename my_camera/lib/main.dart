import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_camera/network_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _imageFile;

  dynamic _pickImageError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildImage(),
                _buildPreview(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildButton(),
            )
          ],
        ),
      ),
    );
  }

  void _pickImage(ImageSource source) async {
    try {
      _imageFile = await ImagePicker.pickImage(
        source: source,
      );

      if (_imageFile != null) {
        _cropImage();

        print("_imageFile != null");
      }
    } catch (exception) {
      _pickImageError = exception;
      setState(() {});
    }
  }

  Future<Null> _cropImage() async {
    await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          statusBarColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
      maxWidth: 500,
      maxHeight: 500,
      //circleShape: true
    ).then((file) {
      if (file != null) {
        _imageFile = file;
        setState(() {});
      }
    });
  }

  _buildImage() => Expanded(
        child: Image.network(
          "https://miro.medium.com/max/584/1*DWrRhRe2O2V6zIfSugZAIw.png",
          fit: BoxFit.cover,
          height: 150,
          width: double.infinity,
        ),
      );

  _buildPreview() {
    Widget widget = Text("Select Image");
    if (_pickImageError != null) {
      widget = Text(_pickImageError);
    } else if (_imageFile != null) {
      widget = SizedBox.expand(
        child: Image.file(
          _imageFile,
          fit: BoxFit.cover,
        ),
      );
    }

    return Expanded(
      flex: 4,
      child: Center(
        child: widget,
      ),
    );
  }

  _buildButton() => Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            WidgetFAB(
              function: () {
                _pickImage(ImageSource.camera);
              },
              icon: Icons.camera,
            ),
            WidgetFAB(
              function: () {
                _uploadImage();
              },
              icon: Icons.cloud_upload,
              color: Colors.red,
            ),
            WidgetFAB(
              function: () {
                _pickImage(ImageSource.gallery);
              },
              icon: Icons.photo_library,
            ),
          ],
        ),
      );

  Future<void> _uploadImage() async {
    final result = await NetWorkService.upload(_imageFile);

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text(result),
          actions: <Widget>[
            FlatButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}

@immutable
class WidgetFAB extends StatelessWidget {
  final VoidCallback function;
  final IconData icon;
  final Color color;

  const WidgetFAB({
    @required this.function,
    this.color,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(icon),
      onPressed: function,
      backgroundColor: color,
    );
  }
}
