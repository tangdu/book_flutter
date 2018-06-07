import 'package:flutter/material.dart';
import 'package:hello/model/zhuanLanPostEntity.dart';
import 'package:hello/component/webview.dart';

class ZhuanLanPostDetailWidget extends StatefulWidget {
  ZhuanLanPostDetailWidget({Key key, this.data}) : super(key: key);
  final ZhuanLanPostEntity data;
  @override
  State<StatefulWidget> createState() =>
      new ZhuanLanPostDetailWidgetState(data: this.data);
}

class ZhuanLanPostDetailWidgetState extends State<ZhuanLanPostDetailWidget> {
  ZhuanLanPostDetailWidgetState({Key key, this.data});
  final ZhuanLanPostEntity data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.launch('https://xiumi.us/#/studio/prototype/papers');
    return new Container(child: new Text('data'),);
  }
}

class ZhuanLanPostDetailPage extends StatelessWidget {
  ZhuanLanPostDetailPage({Key key, this.data}) : super(key: key);
  final ZhuanLanPostEntity data;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            child: new ZhuanLanPostDetailWidget(
      data: data,
    )));
  }

  // Future<ZhuanLanPostDetailEntity> loadDetail() async {
  //   //final String url = "https://zhuanlan.zhihu.com/api/posts/$id";
  //   final String _url="https://zhuanlan.zhihu.com$url";
  //   print(_url);
  //   final response = await http
  //       .get(Uri.encodeFull(_url), headers: {"Accept": "application/json"});
  //   return ZhuanLanPostDetailEntity.fromJson(json.decode(response.body));
  // }
}
