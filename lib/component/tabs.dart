import 'package:flutter/material.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key key}) : super(key: key);
  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    new Tab(
      icon: new Icon(Icons.add),
    ),
    new Tab(
      icon: new Icon(Icons.dehaze),
    ),
    new Tab(icon: new Icon(Icons.done)),
    new Tab(
      icon: new Icon(Icons.crop_free),
    ),
    new Tab(
      icon: new Icon(Icons.edit_location),
    ),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: Colors.deepOrange,
        child: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: myTabs,
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return new Center(child: new Text(tab.icon.toString()));
        }).toList(),
      ),
    );
  }
}
