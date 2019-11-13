import 'package:cm_camera/services/network_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CM CAMERA',
      theme: ThemeData(
        fontFamily: "ZCool",
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
      body: body(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _imageFile.delete();
  }

  Widget body() {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: headerImage(),
              ),
              Expanded(
                flex: 4,
                child: _previewImage(),
              ),
            ],
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: footerButton(),
          ),
        ],
      ),
    );
  }

  Widget headerImage() => Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Image.asset(
          "assets/images/header_home.png",
          width: double.infinity,
        ),
      );

  Widget _previewImage() => Center(
        child: _imageFile != null
            ? SizedBox.expand(
                child: GestureDetector(
                  onTap: _cropImage,
                  child: Image.file(
                    _imageFile,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : _pickImageError != null
                ? Text(
                    'Pick image error: $_pickImageError',
                    textAlign: TextAlign.center,
                  )
                : const Text(
                    'You have not yet picked an image.',
                    textAlign: TextAlign.center,
                  ),
      );

  Widget footerButton() => Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            cameraButton(),
            uploadButton(),
            galleryButton(),
          ],
        ),
      );

  Widget galleryButton() => FloatingActionButton(
        onPressed: () {
          _pickImage(ImageSource.gallery);
        },
        tooltip: 'Pick Image from gallery',
        child: const Icon(Icons.photo_library),
      );

  Widget uploadButton() => FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          if (_imageFile == null) {
            showAlertDialog(text: "Please Pick Image");
          } else {
            String result = await NetWorkService.upload(_imageFile);
            showAlertDialog(text: result);
          }
        },
        tooltip: 'Upload to Server',
        child: const Icon(Icons.file_upload),
      );

  Widget cameraButton() => FloatingActionButton(
        onPressed: () {
          _pickImage(ImageSource.camera);
        },
        tooltip: 'Take a Photo',
        child: const Icon(Icons.photo_camera),
      );

  void _pickImage(ImageSource source) async {
    try {
      _imageFile = await ImagePicker.pickImage(
        source: source,
      );
      _cropImage();
    } catch (exception) {
      _pickImageError = exception;
      setState(() {});
    }
  }

  void showAlertDialog({String text}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  Future<Null> _cropImage() async {
    /**
     * Config Android
     * - gradle.properties (Support AndroidX)
     * - build.gradle (project)
     * - AndroidManifest.xml (Add Activity)
     * - gradle-wrapper.properties
     */
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
      }
    });

    if (_imageFile != null) {
      setState(() {});
    }
  }
}
