import 'package:flutter/material.dart';
import 'package:flutter_todo4/screens/first_view.dart';
import 'package:flutter_todo4/screens/home_view.dart';
import 'package:flutter_todo4/constants/load_images.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final LoadImage loadImage = LoadImage();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future.wait([
      loadImage.loadImg(context, 'assets/1.jpeg'),
      loadImage.loadImg(context, 'assets/3.jpg'),
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: FirstView(),
    );
  }
}
