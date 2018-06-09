import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math' show Random;
import 'package:hello/model/Smartisan.dart';
import 'package:hello/model/ZhiHuHotEntity.dart';
import 'package:hello/views/zhihu_question_detail.dart';

import 'package:http/http.dart' as http;
import 'package:hello/views/html_view.dart';

//创建锤子阅读
Widget createChuiZiView(BuildContext context, SmartisanTopic data) {
  return new Column(
    children: <Widget>[
      new Padding(
        padding: new EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
        child: new ListTile(
          dense: false,
          trailing: new Material(
            borderRadius: new BorderRadius.circular(8.0),
            child: Image.network(data.prepic1,
                fit: BoxFit.cover, height: 60.0, width: 100.0),
          ),
          title: new Text(data.title),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ChuiZiHtmlLoadView(
                        title: data.title,
                        url: data.origin_url,
                      )),
            );
          },
        ),
      ),
      new Divider()
    ],
  );
}

//创建锤子阅读
Widget createZhiHuView(BuildContext context, ZhiHuHotEntity data) {
  return new Column(
    children: <Widget>[
      new Padding(
        padding: new EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
        child: new ListTile(
          dense: false,
          trailing: new Material(
            borderRadius: new BorderRadius.circular(8.0),
            child: Image.network(data.image,
                fit: BoxFit.cover, height: 60.0, width: 100.0),
          ),
          title: new Text(data.title),
          subtitle: new Text(data.sno_text),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ZhiHuQuestionPage(
                        data: data,
                      )),
            );
          },
        ),
      ),
      new Divider()
    ],
  );
}

class ZhihutopicPage extends StatefulWidget {
  @override
  _ZhihutopicPage createState() => new _ZhihutopicPage();
}

class _ZhihutopicPage extends State<ZhihutopicPage> {
  _ZhihutopicPage({Key key});
  List<SmartisanTopic> sList = [];
  List<ZhiHuHotEntity> zList = [];
  static Random shaker = new Random();


  Future<Null> loadChuiZi() async {
    //"http://reader.smartisan.com/index.php?r=visitor/getList&site_ids=1";

    List cates=[999,16,34,15,44];
    int cateIdx=shaker.nextInt(cates.length);
    print(cateIdx);
    final String url =
        "http://reader.smartisan.com/index.php?r=find/GetArticleList&cate_id=${cates[cateIdx]}&offset=0&page_size=20";
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var data = json.decode(response.body);
    setState(() {
      sList = SmartisanTopic.fromJson(data['data']['list']);
    });
  }


  Future<Null> loadZhihuHot() async {
    final String url =
        "https://www.zhihu.com/api/v3/feed/topstory/hot-list-wx?limit=50";
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var data = json.decode(response.body);
    setState(() {
      zList = ZhiHuHotEntity.fromJson(data['data']);
    });
  }

  @override
  void initState() {
    super.initState();
    loadChuiZi();
    loadZhihuHot();
  }

  Widget createChuiZiListView() {
    return new RefreshIndicator(
      child: new ListView(
        children:
            sList.map((item) => createChuiZiView(context, item)).toList()),
      onRefresh: loadChuiZi,
    );
  }

  Widget createZhiHuListView() {
    return new ListView(
        children: zList.map((item) => createZhiHuView(context, item)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.orangeAccent,
          title: new TabBar(
            indicatorWeight: 1.0,
            tabs: [
              new Tab(text: '精选'),
              new Tab(text: '热门'),
              new Tab(text: '美食'),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: new TabBarView(
          children: [
            createChuiZiListView(),
            createZhiHuListView(),
            new Center(child: new Text('我只爱美食，就和美女一样.')),
          ],
        ),
      ),
    );
  }
}
