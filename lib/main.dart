import 'package:flutter/material.dart';
import 'package:hello/views/zhihulive.dart';
import 'package:hello/views/zhihutopic.dart';
import 'package:hello/views/zhuanlan.dart';
import 'package:hello/component/icon_tab.dart';

void main() => runApp(new AppComponent());

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return new AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Hello '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tab = new DefaultTabController(
    length: 3,
    child: new Scaffold(
      // appBar: new AppBar(
      //   title: new Text('Temo'),
      // ),
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text('tdu'), //用户名
            accountEmail: new Text('tdu@126.com'), //用户邮箱
          ),
          new ListTile(
              title: new Text('用户'),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {}),
          new Divider(),
          new ListTile(
              title: new Text('系统'),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {}),
        ],
      )),
      bottomNavigationBar: new Material(
          type: MaterialType.button,
          color: Colors.blue,
          child: new TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: new TextStyle(fontSize: 11.0, color: Colors.white),
            tabs: [
              new IconTab(
                  icon: new Icon(
                    Icons.directions_car,
                    size: 30.0,
                  ),
                  text: 'Live'),
              new IconTab(
                  icon: new Icon(
                    Icons.room,
                    size: 30.0,
                  ),
                  text: 'Live'),
              new IconTab(
                  icon: new Icon(
                    Icons.sim_card,
                    size: 30.0,
                  ),
                  text: '专栏'),
            ],
          )),
      body: new TabBarView(
        children: [
          new Container(
            child: new ZhihulivePage(),
          ),
          new Container(
            child: new ZhihutopicPage(),
          ),
          new Container(
            child: new ZhuanLanDetailPage(),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return tab;
  }
}
