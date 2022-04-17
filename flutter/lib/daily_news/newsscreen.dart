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
        title: Text("News App", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),

      //Now let's call the APi services with future builder widget
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            //Now let's make a list of articles
            List<Article>? articles = snapshot.data;
            // for (var news in articles!) {
            //   print(news);
            // }
            //news=articles?articles[0].title:"hello";
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
                  //Now let's create our custom List tile
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