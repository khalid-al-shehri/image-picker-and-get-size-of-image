import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;

  Future getImage(String source) async {

    var image;

    if(source == "gallery"){
      image = await ImagePicker.pickImage(
          source: ImageSource.gallery
      );
    }else if(source == "camera"){
      image = await ImagePicker.pickImage(
          source: ImageSource.camera
      );
    }

    // MB format
    double imageSize = (image.lengthSync() / 1024) / 1024;

    if(imageSize > 2.0){
      print("Image size : ${imageSize}");
      print("You should select another image, because this image too big. (More than 2MB)");
    }else{
      print("Image size : ${imageSize}");
      setState(() {
        _image = image;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: (){
              getImage("gallery");
            },
            heroTag: "gallery",
            tooltip: 'Pick Image',
            child: Icon(Icons.photo),
          ),

          SizedBox(height: 10,),

          FloatingActionButton(
            onPressed: (){
              getImage("camera");
            },
            heroTag: "camera",
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),
        ],
      )
    );
  }
}
