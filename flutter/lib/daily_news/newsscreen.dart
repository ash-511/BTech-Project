import 'dart:async';
import 'services/api_service.dart';
import 'package:flutter/material.dart';
import 'components/customListTile.dart';
import 'model/article_model.dart';
import 'package:flutter_tts/flutter_tts.dart';


class DailyNewsPage extends StatefulWidget {
  @override
  _DailyNewsPageState createState() => _DailyNewsPageState();
}

class _DailyNewsPageState extends State<DailyNewsPage> {
  ApiService client = ApiService();
  FlutterTts flutterTts = FlutterTts();

  String news="";

  @override
  Future _speak(String text) async{
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily News"),
          backgroundColor: Color(0XFF040045),
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/Iris_logo.jpeg'),
          )
      ),
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article>? articles = snapshot.data;
            if (articles==null){
              return Container(
              );
            }
            String news="1.";
            for (var i=0;i<8;i++){
              int c=i+2;
              news=news+articles[i].title + ".";
              news=news+c.toString()+" . ";
            }
            _speak(news);

            return Column(
              children: [
                Expanded(child:ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) =>
                      customListTile(articles[index], context),
                ),)
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}