import 'package:flutter/material.dart';
// import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import 'package:hello/model/zhuanLanPostEntity.dart';
import 'package:transparent_image/transparent_image.dart';

class ZhiHtmlView extends StatelessWidget {
  ZhiHtmlView({Key key, this.data}) : super(key: key);
  final ZhuanLanPostEntity data;

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(data.title), backgroundColor: Colors.blue),
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
            new HtmlTextView(data: data.content)
          ],
        ));
  }
}
