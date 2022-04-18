import 'package:NewsApp/daily_news/model/article_model.dart';
import 'package:flutter/material.dart';

Widget customListTile(Article article, BuildContext context) {
  return InkWell(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 7.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Color(0XFFA1AFFF),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              article.source.name,
              style: TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
          )
        ],
      ),
    ),
  );
}
