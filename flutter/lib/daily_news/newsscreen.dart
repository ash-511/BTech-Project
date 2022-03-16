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
  String? news;
  @override
  Widget build(BuildContext context) {

    Future _speak(String text) async{
      await flutterTts.speak(text);
    }
    // @override
    // String toString() {
    //   return 'Article':{source: ${source}, title:${title}}
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text("News App", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),

      //Now let's call the APi services with futurebuilder widget
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            //Now let's make a list of articles
            List<Article>? articles = snapshot.data;
            for (var news in articles!) print(news);
            //news=articles?articles[0].title:"hello";
            if (articles==null){
              return Container(
              );
            }
            //return
            // ListView.builder(
            // //Now let's create our custom List tile
            // itemCount: articles.length,
            //   itemBuilder: (context, index) =>
            //       customListTile(articles[index], context),
            // );
            return Column(
              children: [
                ElevatedButton(onPressed: () async {await _speak(" ");} ,
                    child: Text("Speak")),
                Expanded(child:ListView.builder(
                  //Now let's create our custom List tile
                  itemCount: articles.length,
                  itemBuilder: (context, index) =>
                      customListTile(articles[index], context),
                ),),
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