import 'package:flutter/material.dart';
import 'package:hello/model/zhuanLanColumnEntity.dart';
import 'package:hello/model/zhuanLanPostEntity.dart';
import 'package:hello/views/html_view.dart';
import 'package:transparent_image/transparent_image.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ZhuanLanPostColumnView extends StatelessWidget {
  ZhuanLanPostColumnView({Key key, this.category, this.name}) : super(key: key);
  final String category;
  final String name;

  Future<List<ZhuanLanColumnEntity>> fetchColumnData() async {
    final String url =
        "https://zhuanlan.zhihu.com/api/columns${category}/posts?limit=20";
    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    return ZhuanLanColumnEntity.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    Widget listItem(context, index, ZhuanLanColumnEntity info) {
      return new InkWell(
        child: new Card(
          child: new Column(
            children: <Widget>[
              new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: info.titleImage,
                  height: 180.0,
                  width: 1000.0,
                  fit: BoxFit.cover),
              new Padding(
                padding: new EdgeInsets.all(8.0),
                child: new Text(info.title),
              )
            ],
          ),
        ),
        onTap: () {
          ZhuanLanPostEntity entity = new ZhuanLanPostEntity(
            title: info.title,
            titleImage: info.titleImage,
            summary: "",
            publishedTime: info.publishedTime,
            authorName: info.authorName,
            commentsCount: info.commentsCount,
            likesCount: info.likesCount,
            url: info.url,
            content: info.content,
            id: info.id,
          );

          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ZhiHtmlView(data: entity)),
          );
        },
      );
    }

    return new Scaffold(
        appBar: new AppBar(title: new Text(name)),
        body: new Center(
          child: new FutureBuilder<List<ZhuanLanColumnEntity>>(
            future: fetchColumnData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) =>
                        listItem(context, index, snapshot.data[index]));
              } else if (snapshot.hasError) {
                return new Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}
