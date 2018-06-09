import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/views/zhihulive.dart';
import 'package:hello/views/zhihutopic.dart';
import 'package:hello/views/zhuanlan.dart';
import 'package:hello/component/icon_tab.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(new AppComponent());

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.grey,
  accentColor: Colors.grey[100],
);

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
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme //new
          : kDefaultTheme,
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

class TabPage {
  Widget title;
  Widget view;
  TabPage({this.title, this.view});
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<TabPage> tabs = <TabPage>[
    TabPage(
        title: new IconTab(
            icon: new Icon(
              Icons.dashboard,
              size: 30.0,
            ),
            text: 'Live'),
        view: ZhihulivePage()),
    TabPage(
        title: new IconTab(
            icon: new Icon(
              Icons.toc,
              size: 30.0,
            ),
            text: '热门'),
        view: ZhihutopicPage()),
    TabPage(
        title: new IconTab(
            icon: new Icon(
              Icons.eject,
              size: 30.0,
            ),
            text: '专栏'),
        view: ZhuanLanDetailPage()),
  ];

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: new Drawer(
            child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('阿豆'), //用户名
              accountEmail: new Text('tangdu0228@aliyun.com'), //用户邮箱
              // currentAccountPicture:Image.asset("images/user_bk.jpg"),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/user_bk.jpg'))),
            ),
            new ListTile(
                title: new Text('菠萝'),
                trailing: new Icon(Icons.arrow_upward),
                onTap: () {}),
            new Divider(),
            new ListTile(
                title: new Text('猪蹄'),
                trailing: new Icon(Icons.arrow_upward),
                onTap: () {}),
            new Divider(),
            new ListTile(
                title: new Text('鸡爪'),
                trailing: new Icon(Icons.arrow_upward),
                onTap: () {}),
          ],
        )),
        bottomNavigationBar: new Material(
            type: MaterialType.transparency,
            color: Colors.white,
            child: new TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: new TextStyle(fontSize: 11.0, color: Colors.blue),
              tabs: tabs.map((p) => p.title).toList(),
            )),
        body: new TabBarView(
            controller: _tabController,
            children: tabs.map((p) => p.view).toList()));
  }
}
