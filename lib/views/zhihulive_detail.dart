import 'package:flutter/material.dart';
import 'package:hello/model/zhuanLiveDetailEntity.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

// _createPillButton(
//   String text, {
//   Color backgroundColor = Colors.transparent,
//   Color textColor = Colors.white70,
// }) {
//   return new ClipRRect(
//     borderRadius: new BorderRadius.circular(10.0),
//     child: new MaterialButton(
//       minWidth: 60.0,
//       padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//       height: 25.0,
//       color: backgroundColor,
//       textColor: textColor,
//       onPressed: () {},
//       child: new Text(text,
//           style: new TextStyle(fontSize: 12.0, color: Colors.black54)),
//     ),
//   );
// }


class ZhihuliveDetail extends StatefulWidget {
  ZhihuliveDetail({Key key, this.liveId, this.title}) : super(key: key);
  final String liveId;
  final String title;
  @override
  State<StatefulWidget> createState() {
    return new ZhihuliveDetailState(liveId: liveId, title: title);
  }
}

class ZhihuliveDetailView extends StatelessWidget {
  ZhihuliveDetailView({Key key, this.detail}) : super(key: key);
  final ZhuanLiveDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    // var textTheme = theme.textTheme;
    var avatar = new Hero(
        tag: 1,
        child: new Material(
            elevation: 4.0,
            borderRadius: new BorderRadius.circular(10.0),
            shadowColor: new Color(0x802196F3),
            child: new Image.network(
              detail.avatarUrl,
              height: 60.0,
              width: 60.0,
            )));

    var card1 = new Material(
        // elevation: 14.0,
        // borderRadius: new BorderRadius.circular(12.0),
        // shadowColor: new Color(0x802196F3),
        child: new Container(
            padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: new Column(children: <Widget>[
              new Row(children: <Widget>[
                new Column(
                  children: <Widget>[avatar, new Text(detail.badgeName)],
                ),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      padding: new EdgeInsets.all(6.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            detail.subject,
                            style: new TextStyle(fontSize: 15.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                          new Text(''),
                          new Text('@' + detail.speakerName,
                              style: new TextStyle(
                                  fontSize: 15.0, color: Colors.black54))
                        ],
                      ),
                    )
                  ],
                )
              ])
            ])));

    var card2 = new Container(
        margin: new EdgeInsets.only(top: 10.0),
        child: new Material(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        'Live简介',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
              new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 0.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(detail.speakerDescription,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ))
            ])));

    return new Container(
        decoration: new BoxDecoration(color: Colors.grey[300]),
        child: new Column(
          children: <Widget>[card1, card2],
        ));
  }
}

class ZhihuliveDetailState extends State<ZhihuliveDetail> {
  ZhihuliveDetailState({Key key, this.liveId, this.title});
  final String liveId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          margin: new EdgeInsets.only(top: 16.0),
          child: new Center(
              child: new FutureBuilder<ZhuanLiveDetailEntity>(
                  future: fetchLiveInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var detail = snapshot.data;
                      return new ZhihuliveDetailView(
                        detail: detail,
                      );
                    } else if (snapshot.hasError) {
                      return new Text('${snapshot.error}');
                    }
                    return new CircularProgressIndicator();
                  }))),
      floatingActionButton: new Theme(
        // override the accent color of theme for this widget only
        data: Theme.of(context).copyWith(accentColor: Colors.pinkAccent),
        child: new FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: new Icon(Icons.reply_all),
        ),
      ),
    );
  }

  Future<ZhuanLiveDetailEntity> fetchLiveInfo() async {
    final String url = "https://api.zhihu.com/lives/$liveId";
    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    return ZhuanLiveDetailEntity.fromJson(json.decode(response.body));
  }
}
