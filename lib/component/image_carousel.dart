import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageCarousel extends StatefulWidget {
  final List<ImageProvider> imageProviders;
  final double height;
  final TargetPlatform platform;
  final Duration interval;
  final bool allowZoom;
  final TabController tabController;
  final BoxFit fit;

  // Images will shrink according to the value of [height]
  // If you prefer to use the Material or Cupertino style activity indicator set the [platform] parameter
  // Set [interval] to let the carousel loop through each photo automatically
  // Pinch to zoom will be turned on by default
  ImageCarousel(this.imageProviders,
      {this.height = 250.0,
      this.platform,
      this.interval,
      this.allowZoom = true,
      this.tabController,
      this.fit = BoxFit.cover});

  @override
  State createState() => new _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel>
    with SingleTickerProviderStateMixin {
  TabController controller;
  List<Widget> circles;
  var page = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    controller = widget.tabController ??
        new TabController(length: widget.imageProviders.length, vsync: this);

    _timer?.cancel();

    if (widget.interval != null) {
      _timer = new Timer.periodic(widget.interval, (_) {
        nextPage();
      });
    }
  }

  void nextPage() {
    const _kCurve = Curves.ease;
    const _kDuration = const Duration(milliseconds: 300);
    page = controller.index;

    if (page < controller.length - 1) {
      page++;
    } else {
      page = 0;
    }
    controller.animateTo(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  static const double _kDotSize = 5.0;
  static const double _kMaxZoom = 3.0;
  static const double _kDotSpacing = 15.0;

  Widget _buildDot() {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - (controller.length - page).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Material(
        color: Colors.black,
        type: MaterialType.circle,
        child: new Container(
          width: _kDotSize * zoom,
          height: _kDotSize * zoom,
          child: new InkWell(
            onTap: () => nextPage(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
        height: widget.height,
        child: new Stack(
          children: <Widget>[
            new TabBarView(
              controller: controller,
              children: widget.imageProviders.map((ImageProvider provider) {
                return new Image(
                  image: provider,
                  fit: widget.fit,
                );
              }).toList(),
            ),
            new Positioned(
                bottom: 0.0,
                right: 0.0,
                child: new Row(
                  children: [_buildDot(), _buildDot(), _buildDot()],
                )),
          ],
        ));
  }
}
