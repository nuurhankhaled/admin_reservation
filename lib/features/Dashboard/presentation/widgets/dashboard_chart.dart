import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class MainLayoutChart extends StatelessWidget {
  Map<dynamic,dynamic> map ;
  MainLayoutChart({required this.map});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          LineSeries<ChartData, String>(
            dataSource: [
              for(int i = 0 ; i < map.keys.toList().length && !map.keys.toList().isEmpty ; i++)...[
                ChartData(map.keys.toList()[i].toString() , map.values.toList()[i]*1.0),
              ]
            ],
            xValueMapper: (ChartData data, _) => data.x ,
            yValueMapper: (ChartData data, _) => data.y
          ),

        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
