import 'package:flutter_web/material.dart';

import 'cloud_render.dart';

class CloudWidget extends MultiChildRenderObjectWidget {
  final Overflow overflow;
  final double ratio;

  CloudWidget({
    Key key,
    this.ratio = 1,
    this.overflow = Overflow.clip,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCloudWidget(
      ratio: ratio,
      overflow: overflow,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderCloudWidget renderObject) {
    renderObject
      ..ratio = ratio
      ..overflow = overflow;
  }
}