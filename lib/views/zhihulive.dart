import 'package:flutter/material.dart';
import 'package:hello/views/zhihulive_detail.dart';
import 'package:hello/model/zhuanLiveEntity.dart';
import 'package:hello/component/image_carousel.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ZhihulivePage extends StatefulWidget {
  @override
  ZhihuliveState createState() => new ZhihuliveState();
}

Future<List<ZhuanLiveEntity>> loadZhihuLive() async {
  final String url = "https://api.zhihu.com/lives/homefeed?includes=live";
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  var dataConvertedToJSON = json.decode(response.body);
  return ZhuanLiveEntity.fromJson(dataConvertedToJSON['data']);
}

class ZhihuliveState extends State<ZhihulivePage> {
  List<ZhuanLiveEntity> data;

  var imageBox = new ImageCarousel([
    new NetworkImage(
        'https://pic4.zhimg.com/v2-9d6561747e5f80e69ac1be7854d95f34_r.jpg'),
    new NetworkImage(
        'https://pic4.zhimg.com/v2-9134f0d73044b418613cad9e6f506923_r.jpg'),
    new NetworkImage(
        'https://pic1.zhimg.com/v2-0592b61978e2636f38fd0f6ca5457484_r.jpg')
  ], interval: new Duration(seconds: 3), height: 156.0);

  Widget createLiveView(BuildContext context, ZhuanLiveEntity data) {
    var tags = data.tags;
    var liveId = data.id;
    var subject = data.subject;
    var name = data.speakerName;
    var taken = data.seatTaken;
    var score = data.score;
    var avatarUrl = data.avatarUrl;
    var tagNames = [];
    tags.forEach((x) => tagNames.add(x['name']));

    return new Column(children: <Widget>[
      new Container(
          child: new Row(children: [
        new Expanded(
            child: ListTile(
          title: Text(subject,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600)),
          subtitle: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[new Text(name)],
              ),
              new Row(
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.star,
                              color: score > 1 ? Colors.yellow : Colors.black12,
                              size: 16.0),
                          new Icon(Icons.star,
                              color: score > 2 ? Colors.yellow : Colors.black12,
                              size: 16.0),
                          new Icon(Icons.star,
                              color: score > 3 ? Colors.yellow : Colors.black12,
                              size: 16.0),
                          new Icon(Icons.star,
                              color: score > 4 ? Colors.yellow : Colors.black12,
                              size: 16.0),
                          new Icon(Icons.star,
                              color: score > 5 ? Colors.yellow : Colors.black12,
                              size: 16.0),
                        ],
                      ),
                    ],
                  ),
                  new Padding(
                    child: new Text('$taken人参与',
                        style: TextStyle(
                          fontSize: 12.0,
                        )),
                    padding: new EdgeInsets.symmetric(horizontal: 4.0),
                  )
                ],
              ),
              new Row(
                children: <Widget>[
                  new Material(
                    borderRadius: new BorderRadius.circular(3.0),
                    color: Colors.grey,
                    child: new Padding(
                      padding: new EdgeInsets.all(4.0),
                      child: new Text(tagNames.toString(),
                          style: new TextStyle(
                              color: Colors.white, fontSize: 8.0)),
                    ),
                  )
                ],
              )
            ],
          ),
          onTap: () {
            // Navigator.of(context).pushNamed('/add_page');
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ZhihuliveDetail(
                        liveId: liveId,
                        title: subject,
                      )),
            );
          },
        )),
        new Padding(
          padding: new EdgeInsets.only(left: 0.0, right: 16.0, bottom: 0.0),
          child: new Material(
              borderRadius: new BorderRadius.circular(10.0),
              child: new Image.network(
                avatarUrl,
                height: 50.0,
                width: 50.0,
              )),
        )
      ])),
      new Divider(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        scrollDirection: Axis.vertical,
        // padding: new EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.only(bottom: 20.0), child: imageBox),
          new Center(
              child: new FutureBuilder<List<ZhuanLiveEntity>>(
                  future: loadZhihuLive(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var list = snapshot.data;
                      Iterable<Widget> views = list.map((ZhuanLiveEntity data) {
                        return createLiveView(context, data);
                      });
                      return new Column(
                        children: views.toList(),
                      );
                    } else if (snapshot.hasError) {
                      return new Text('${snapshot.error}');
                    }
                    return new CircularProgressIndicator();
                  }))
        ],
      ),
    );
  }
}
