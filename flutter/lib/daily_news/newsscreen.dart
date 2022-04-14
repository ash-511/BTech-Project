import 'services/api_service.dart';
import 'package:flutter/material.dart';
import 'components/customListTile.dart';
import 'model/article_model.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:alan_voice/alan_voice.dart';

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
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);
  }

  _DailyNewsPageState(){
    String sdkKey = "f4b5ec72bdd281a7780bdbb62601ddf42e956eca572e1d8b807a3e2338fdd0dc/stage";

    Future<void> _readNews(Map<String, dynamic> command) async {
      switch (command["command"]) {
        case "news":
          await _speak(news);
          break;
        default:
          debugPrint("Unknown command: ${command}");
      }
    }
    AlanVoice.addButton(sdkKey,buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.onCommand.add((command) => _readNews(command.data));
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

            return Column(
              children: [
                ElevatedButton(onPressed: () async {await _speak(news);} ,
                    child: Text("Speak")),
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