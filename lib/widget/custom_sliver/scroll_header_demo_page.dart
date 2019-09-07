import 'package:flutter_web/material.dart';
import 'package:flutter_web/rendering.dart';
import 'custom_sliver.dart';

class ScrollHeaderDemoPage extends StatefulWidget {
  @override
  _ScrollHeaderDemoPageState createState() => _ScrollHeaderDemoPageState();
}

class _ScrollHeaderDemoPageState extends State<ScrollHeaderDemoPage> with SingleTickerProviderStateMixin {
  GlobalKey<CustomSliverState> globalKey = new GlobalKey();

  final ScrollController controller = ScrollController(initialScrollOffset: -70);

  double initLayoutExtent = 70;
  final double indicatorExtent = 200;
  final double triggerPullDistance = 300;
  final double showPullDistance = 150;
  bool pinned = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: new Text("ScrollHeaderDemoPage"),
      ),
      body: new NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.metrics.pixels < -showPullDistance) {
              globalKey.currentState.handleShow();
            } else if (notification.metrics.pixels > 5) {
              globalKey.currentState.handleHide();
            }
          }
          return false;
        },
        child: CustomScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            CustomSliver(
              key: globalKey,
              initLayoutExtent: initLayoutExtent,
              containerExtent: indicatorExtent,
              triggerPullDistance: triggerPullDistance,
              pinned: pinned,
            ),

            ///列表区域
            SliverSafeArea(
              sliver: SliverList(
                ///代理显示
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Card(
                      child: new Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: new Text("Item $index"),
                      ),
                    );
                  },
                  childCount: 40,
                ),
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        new RaisedButton(
          onPressed: () async {
            setState(() {
              pinned = !pinned;
            });
          },
          child: new Text(
            pinned ? "pinned" : "scroll",
            style: TextStyle(color: Colors.white),
          ),
        ),
        new RaisedButton(
          onPressed: () async {
            setState(() {
              if (initLayoutExtent == 0) {
                initLayoutExtent = 70;
              } else {
                initLayoutExtent = 0;
              }
            });
          },
          child: new Text(
            initLayoutExtent != 0 ? "minHeight" : "non Height",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
