import 'dart:math';

import 'package:flutter/material.dart';

class ZoomableChart extends StatefulWidget {
  double max_x;
  Widget Function(double, double) builder;

  ZoomableChart({
    super.key,
    required this.max_x,
    required this.builder,
  });

  @override
  State<ZoomableChart> createState() => _ZoomableChartState();
}

class _ZoomableChartState extends State<ZoomableChart> {
  late double min_x;
  late double max_x;

  late double lastMaxXValue;
  late double lastMinXValue;

  @override
  void initState() {
    super.initState();
    min_x = 0;
    max_x = widget.max_x;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          min_x = 0;
          max_x = widget.max_x;
        });
      },
      onHorizontalDragStart: (details) {
        lastMinXValue = min_x;
        lastMaxXValue = max_x;
      },
      onHorizontalDragUpdate: (details) {
        var horizontalDistance = details.primaryDelta ?? 0;
        if (horizontalDistance == 0) return;
        print('horizontalDistance: $horizontalDistance');
        print('lastMinXValue: $lastMinXValue, lastMaxXValue: $lastMaxXValue');
        var lastMinMaxDistance = max(lastMaxXValue - lastMinXValue, 0.0);
        print('lastMinMaxDistance: $lastMinMaxDistance');
        setState(() {
          min_x -= lastMinMaxDistance * 0.005 * horizontalDistance;
          max_x -= lastMinMaxDistance * 0.005 * horizontalDistance;

          if (min_x < 0) {
            min_x = 0;
            max_x = lastMinMaxDistance;
          }
          if (max_x > widget.max_x) {
            max_x = widget.max_x;
            min_x = max_x - lastMinMaxDistance;
          }
          print("onHorizontalDragUpdate - min: $min_x, max: $max_x");
        });
      },
      onScaleStart: (details) {
        lastMinXValue = min_x;
        lastMaxXValue = max_x;
      },
      onScaleUpdate: (details) {
        var horizontalScale = details.horizontalScale;
        if (horizontalScale == 0) return;
        print('horizontalScale: $horizontalScale');
        var lastMinMaxDistance = max(lastMaxXValue - lastMinXValue, 0);
        var newMinMaxDistance = max(lastMinMaxDistance / horizontalScale, 10);
        var distanceDifference = newMinMaxDistance - lastMinMaxDistance;
        print("lastMinMaxDistance: $lastMinMaxDistance, newMinMaxDistance: $newMinMaxDistance, distanceDifference: $distanceDifference");
        setState(() {
          final newMinX = max(
            lastMinXValue - distanceDifference,
            0.0,
          );
          final newMaxX = min(
            lastMaxXValue + distanceDifference,
            widget.max_x,
          );

          if (newMaxX - newMinX > 2) {
            min_x = newMinX;
            max_x = newMaxX;
          }
          print("onScaleUpdate - min: $min_x, max: $max_x");
        });
      },
      child: widget.builder(min_x, max_x),
    );
  }
}
