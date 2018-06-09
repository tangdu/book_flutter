import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:hello/model/ZhiHuHotEntity.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'package:hello/views/html_view.dart';

class ZhiHuQuestionPage extends StatefulWidget {
  ZhiHuQuestionPage({Key key, this.data}) : super(key: key);
  final ZhiHuHotEntity data;

  @override
  _ZhiHuQuestionPage createState() => new _ZhiHuQuestionPage(data: data);
}

class _ZhiHuQuestionPage extends State<ZhiHuQuestionPage> {
  _ZhiHuQuestionPage({Key key, this.data});
  final ZhiHuHotEntity data;
  List<ZhiHuQuetionEntity> list;

  Future<List<ZhiHuQuetionEntity>> fetchColumnData() async {
    final String url =
        "https://www.zhihu.com/api/v4/questions/${data.id}/answers?include=data[*].voteup_count,excerpt,thumbnail_info.thumbnails[*].data_url&sort_by=default";
    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    return ZhiHuQuetionEntity.fromJson(json.decode(response.body)["data"]);
  }

  Widget listItem(context, ZhiHuQuetionEntity info) {
    return new InkWell(
      child: new Container(
        padding: EdgeInsets.only(top: 10.0),
        child: new Column(
          children: <Widget>[
            new Row(children: [
              new Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                ),
                child: new ClipOval(
                  child: new SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: new Image.network(
                      info.authorAvatar,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text(info.authorName),
              ),
            ]),
            info.thumbnail != ""
                ? new FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: info.thumbnail,
                    height: 180.0,
                    width: 1000.0,
                    fit: BoxFit.cover)
                : new Container(),
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new Text(info.excerpt),
            ),
            new Row(children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("${info.voteupCount}赞同・",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            ]),
            new Container(
              height: 10.0,
              decoration: new BoxDecoration(color: Colors.grey[300]),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new ZhiHuHtmlLoadView(id: info.answerId)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text(this.data.title)),
        body: new Container(
          // decoration: new BoxDecoration(color: Colors.grey[300]),
          child: ListView(
            children: <Widget>[
              // new Center(child:Text(this.data.title,style: TextStyle(fontSize:20.0)),),
              new Padding(
                padding:
                    new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: new Text(
                  this.data.subTitle,
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              new Padding(
                  padding: new EdgeInsets.only(top: 0.0, left: 6.0, right: 0.0),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        '热门回答',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      new Expanded(
                        flex: 1,
                        child: new Container(),
                      ),
                      new FlatButton(
                        child: Text(
                          '切换至最新',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )),
              new Divider(),
              new Center(
                  child: new FutureBuilder<List<ZhiHuQuetionEntity>>(
                      future: fetchColumnData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var list = snapshot.data;
                          Iterable<Widget> views =
                              list.map((ZhiHuQuetionEntity data) {
                            return listItem(context, data);
                          });
                          return new Column(
                            children: views.toList(),
                          );
                        } else if (snapshot.hasError) {
                          return new Text('${snapshot.error}');
                        }
                        return new CircularProgressIndicator();
                      })),
            ],
          ),
        ));
  }
}
