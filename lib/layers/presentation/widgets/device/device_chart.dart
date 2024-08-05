import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DeviceChart extends StatefulWidget {
  Color mainGridColor;
  List<Color> gradientColors;

  double axisVerticalLineWidth;
  double axisHorizontalLineWidth;

  double lineWidth;

  final double min_x;
  final double max_x;
  final double min_y;
  final double max_y;
  final double horizontalInterval;
  final double verticalInterval;
  final double limitRange;
  final List<FlSpot> data;
  final double reduceNum;

  double borderWidth;

  DeviceChart({
    super.key,
    this.mainGridColor = Colors.white70,
    this.gradientColors = const [
      Colors.white,
      Colors.white,
    ],
    this.axisHorizontalLineWidth = 0.25,
    this.axisVerticalLineWidth = 0.25,
    this.lineWidth = 2,
    required this.min_x,
    required this.max_x,
    required this.min_y,
    required this.max_y,
    required this.limitRange,
    required this.data,
    required this.reduceNum,
    this.borderWidth = 0.5,
    required this.horizontalInterval,
    required this.verticalInterval,
  });

  @override
  State<DeviceChart> createState() => _DeviceChartState();
}

class _DeviceChartState extends State<DeviceChart> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: widget.borderWidth),
      ),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 2:
        text = 'MAR';
        break;
      case 5:
        text = 'JUN';
        break;
      case 8:
        text = 'SEP';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.left
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.left
      )
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: widget.horizontalInterval,
        verticalInterval: widget.verticalInterval,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: widget.mainGridColor,
            strokeWidth: widget.axisHorizontalLineWidth,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: widget.mainGridColor,
            strokeWidth: widget.axisVerticalLineWidth,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // bottomTitles: AxisTitles(
        //   sideTitles: SideTitles(
        //     showTitles: true,
        //     reservedSize: 20,
        //     interval: 1,
        //     getTitlesWidget: bottomTitleWidgets,
        //   ),
        // ),
        // leftTitles: AxisTitles(
        //   sideTitles: SideTitles(
        //     showTitles: true,
        //     interval: 1,
        //     getTitlesWidget: leftTitleWidgets,
        //     reservedSize: 30,
        //   ),
        // ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: widget.mainGridColor),
      ),
      minX: widget.min_x,
      maxX: widget.max_x,
      minY: widget.min_y,
      maxY: widget.max_y,
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: widget.limitRange,
            color: Colors.redAccent,
            strokeWidth: widget.lineWidth,
            dashArray: [5, 5],
            label: HorizontalLineLabel(
              show: true,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 5, bottom: 5),
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
              labelResolver: (line) => 'threshold: ${line.y}',
            ),
          ),
        ],
      ),
      lineBarsData: [
        LineChartBarData(
          spots: widget.data,
          isCurved: true,
          gradient: LinearGradient(
            colors: widget.gradientColors,
          ),
          barWidth: widget.lineWidth,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: widget.gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: widget.mainGridColor,
            strokeWidth: widget.axisHorizontalLineWidth,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: widget.mainGridColor,
            strokeWidth: widget.axisVerticalLineWidth,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: widget.mainGridColor),
      ),
      minX: widget.min_x,
      maxX: widget.max_x,
      minY: widget.min_y,
      maxY: widget.max_y,
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: widget.limitRange,
            color: Colors.redAccent,
            strokeWidth: widget.lineWidth,
            dashArray: [5, 10],
            label: HorizontalLineLabel(
              show: true,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 5, bottom: 5),
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
              labelResolver: (line) => 'H: ${line.y}',
            ),
          ),
        ],
      ),
      lineBarsData: [
        LineChartBarData(
          spots: widget.data,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: widget.gradientColors[0], end: widget.gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: widget.gradientColors[0], end: widget.gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: widget.lineWidth,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: widget.gradientColors[0], end: widget.gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: widget.gradientColors[0], end: widget.gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
