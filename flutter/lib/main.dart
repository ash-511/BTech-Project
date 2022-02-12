import 'daily_news/services/api_service.dart';
import 'package:flutter/material.dart';
import 'daily_news/components/customListTile.dart';
import 'daily_news/model/article_model.dart';
import 'daily_news/newsscreen.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
