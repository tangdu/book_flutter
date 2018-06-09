import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:hello/views/zhuanlan_column.dart';
import 'package:hello/views/html_view.dart';
import 'package:hello/model/zhuanLanPostEntity.dart';
import 'package:hello/model/zhuanLanEntity.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ZhuanLanTopicView extends StatefulWidget {
  @override
  ZhuanLanTopicViewState createState() => new ZhuanLanTopicViewState();
}

class ZhuanLanTopicViewState extends State<ZhuanLanTopicView> {
  ZhuanLanTopicViewState({Key key});
  List<ZhuanLanEntity> zlList = [];
  List<ZhuanLanPostEntity> zlpList = [];

  Future<Null> loadZhuanlan() async {
    final String url =
        "https://zhuanlan.zhihu.com/api/recommendations/columns?limit=6";
    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      zlList = ZhuanLanEntity.fromJson(json.decode(response.body));
    });
  }

  Future<Null> loadZhuanlanPost() async {
    final String url =
        "https://zhuanlan.zhihu.com/api/recommendations/posts?limit=4&offset=0&seed=50";
    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      zlpList = ZhuanLanPostEntity.fromJson(json.decode(response.body));
    });
  }

  Future<Null> refreshData() async {
    loadZhuanlan();
    loadZhuanlanPost();
  }

  @override
  void initState() {
    super.initState();
    loadZhuanlan();
    loadZhuanlanPost();
  }

  @override
  Widget build(BuildContext context) {
    createZhuanLanView(ZhuanLanEntity zhuanlan) => Hero(
          tag: zhuanlan.name,
          child: Material(
            elevation: 10.0,
            shadowColor: Colors.blue.shade900,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ZhuanLanPostColumnView(
                              category: zhuanlan.url,
                              name:zhuanlan.name
                            )),
                  );
                },
                child: new Column(
                  children: <Widget>[
                    FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: zhuanlan.avatar,
                        fit: BoxFit.cover),
                    new Padding(
                      padding: new EdgeInsets.only(top: 10.0),
                      child: new Text(
                        '${zhuanlan.name}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    new Text(
                      '${zhuanlan.followersCount}关注',
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ],
                )),
          ),
        );

    Widget createZhuanLanPostView(ZhuanLanPostEntity data) {
      return new Card(
          child: new InkWell(
        child: new Column(
          children: <Widget>[
            new FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: data.titleImage,
                height: 170.0,
                width: 800.0,
                fit: BoxFit.cover),
            new Padding(
              padding: new EdgeInsets.all(12.0),
              child: new Text(data.title),
            )
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ZhiHtmlView(
                      data: data,
                    )),
          );
        },
      ));
    }

    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        new SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: new SliverFixedExtentList(
              itemExtent: 20.0,
              delegate: new SliverChildBuilderDelegate(
                  (builder, index) => new Column(
                        children: <Widget>[
                          new Text('专栏 · 发现',
                              style:
                                  new TextStyle(fontWeight: FontWeight.w600)),
                          new Expanded(
                            child: new Divider(),
                          )
                        ],
                      ),
                  childCount: 1),
            )),
        SliverPadding(
          padding: EdgeInsets.all(5.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: zlList.map((item) => createZhuanLanView(item)).toList(),
          ),
        ),
        new SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: new SliverFixedExtentList(
              itemExtent: 20.0,
              delegate: new SliverChildBuilderDelegate(
                  (builder, index) => new Column(
                        children: <Widget>[
                          new Text('文章 · 发现',
                              style:
                                  new TextStyle(fontWeight: FontWeight.w600)),
                          new Expanded(
                            child: new Divider(),
                          )
                        ],
                      ),
                  childCount: 1),
            )),
        SliverGrid.count(
          childAspectRatio: 1 / 0.6,
          crossAxisCount: 1,
          mainAxisSpacing: 10.0,
          children:
              zlpList.map((item) => createZhuanLanPostView(item)).toList(),
        )
      ],
    );
    return new RefreshIndicator(
      // color: Theme.of(context).buttonColor,
      color:Colors.orange,
      child: grid,
      onRefresh: () => refreshData(),
    );
  }
}

class ZhuanLanDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new ZhuanLanTopicView());
  }
}
