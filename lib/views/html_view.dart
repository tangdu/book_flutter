import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:hello/model/zhuanLanPostEntity.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parse;
import 'package:hello/model/ZhiHuHotEntity.dart';

class ZhiHtmlView extends StatelessWidget {
  ZhiHtmlView({Key key, this.data}) : super(key: key);
  final ZhuanLanPostEntity data;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(title: new Text(data.title)),
        body: new ListView(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 0.0),
              child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: data.titleImage,
                  height: 180.0,
                  width: 1000.0,
                  fit: BoxFit.cover),
            ),
            new HtmlView(data: data.content)
          ],
        ));
  }
}

class ChuiZiHtmlLoadView extends StatelessWidget {
  ChuiZiHtmlLoadView({Key key, this.url, this.title}) : super(key: key);
  final String url;
  final String title;

  String getUrl() {
    return this.url;
  }

  Future<String> loadHtml() async {
    var response = await http.get(Uri.encodeFull(getUrl()),
        headers: {"User-Agent": "Safari/537.36"});
    return response.body;
  }

  HtmlView parseJhtml(String content) {
    var document = parse.parse(content);
    var wrapper = document.querySelector("div.content");
    var html = wrapper.outerHtml;
    html = html.replaceAll("div", "p");
    return new HtmlView(
      data: html,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(title: new Text(this.title)),
        body: new Container(
            child: new FutureBuilder<String>(
                future: loadHtml(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var html = snapshot.data;
                    return new ListView(
                      children: <Widget>[parseJhtml(html)],
                    );
                  } else if (snapshot.hasError) {
                    return new Text('${snapshot.error}');
                  }
                  return new LinearProgressIndicator(
                    backgroundColor: Colors.green,
                    value: 1.0,
                  );
                })));
  }
}

class ZhiHuHtmlLoadView extends ChuiZiHtmlLoadView {
  ZhiHuHtmlLoadView({Key key, this.id}) : super(key: key);
  final int id;

  @override
  String getUrl() {
    return "https://www.zhihu.com/api/v4/answers/${id}?include=excerpt,content,created_time,updated_time,reshipment_settings,author.badge[*].topics";
  }
  @override
  HtmlView parseJhtml(String content) {
    ZhiHuAnswerEntity answerEntity =
        ZhiHuAnswerEntity.fromJson(json.decode(content));
    return HtmlView(
      data: answerEntity.content,
    );
  }
}
