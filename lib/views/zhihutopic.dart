import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
import 'package:hello/component/image_carousel.dart';
import 'package:map_view/map_view.dart';

class ZhihutopicPage extends StatelessWidget {
  ZhihutopicPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // VideoPlayerController controller = new VideoPlayerController.network(
    // 'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4');
    var API_KEY = 'AIzaSyA5KZkMx92olDdA0c0XBkJ4kuTadgUa1Jo';
    // MapView.setApiKey(API_KEY);
    // var mapView = new MapView();
    var staticMapProvider = new StaticMapProvider(API_KEY);
    // mapView.onToolbarAction.listen((id) {
    //   if (id == 1) {
    //     mapView.dismiss();
    //   }
    // });

    List<Marker> _markers = <Marker>[
      new Marker("1", "Work", 45.523970, -122.663081, color: Colors.blue),
      new Marker("2", "Nossa Familia Coffee", 45.528788, -122.684633),
    ];

    var cameraPosition = new CameraPosition(Locations.portland, 2.0);
    var staticMapUri = staticMapProvider.getStaticUri(Locations.portland, 12,
        width: 900, height: 400, mapType: StaticMapViewType.roadmap);

    return new Scaffold(
        body: new Container(
      // child: new RaisedButton(
      //   onPressed: () {
      //     mapView.show(
      //         new MapOptions(
      //             showUserLocation: true,
      //             title: "Choose a favorite"),
      //         toolbarActions: <ToolbarAction>[new ToolbarAction("Close", 1)]);
      //   },
      //   child: new Text("data"),
      // ),
      child: new Center(
        // child: new Image.network(staticMapUri.toString()),

        child: new ImageCarousel([
          new NetworkImage(
              'https://pic4.zhimg.com/v2-9d6561747e5f80e69ac1be7854d95f34_r.jpg'),
          new NetworkImage(
              'https://pic4.zhimg.com/v2-9134f0d73044b418613cad9e6f506923_r.jpg'),
          new NetworkImage(
              'https://pic1.zhimg.com/v2-0592b61978e2636f38fd0f6ca5457484_r.jpg')
        ],interval: new Duration(seconds: 3),),

      ),
    ));
  }
}
