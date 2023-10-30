import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:user_repository/user_repository.dart';

class WeightChart extends StatefulWidget {
  final List<Weight> chartList;
  final String userId;

  const WeightChart({Key? key, required this.chartList, required this.userId})
        : super(key: key);
  
  @override
  State<WeightChart> createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  String smallestWeight = '';
  String largestWeight = '';

  @override
  Widget build(BuildContext context) {
    widget.chartList.sort((a, b) => a.date.compareTo(b.date));
    smallestWeight = widget.chartList.reduce((a, b) => double.parse(a.weight) < double.parse(b.weight) ? a : b).weight;
    largestWeight = widget.chartList.reduce((a, b) => double.parse(a.weight) > double.parse(b.weight) ? a : b).weight;
    return Column(
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.width / 1.8,
            width: MediaQuery.of(context).size.width / 1.1,
            child: widget.chartList.isEmpty 
                ? const Center(child: CircularProgressIndicator())
                : SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(
                    color: Colors.transparent),
                isVisible: false
              ),
              primaryYAxis: NumericAxis(
                minimum: (double.parse(smallestWeight)/10).ceil() * 10 - 10,
                maximum: (double.parse(largestWeight)/10).ceil() * 10 + 10,
                isVisible: false,
              ),
              series: <ChartSeries>[
                // Renders line chart
                LineSeries<Weight, String>(
                  color: Theme.of(context).colorScheme.secondary,
                  dataSource: widget.chartList,
                  xValueMapper: (Weight data, _) => DateFormat('d/M/y').format(data.date),
                  yValueMapper: (Weight data, _) => double.parse(data.weight),
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    height: 6,
                    width: 6,
                  ),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    // Positioning the data label
                    useSeriesColor: true,
                    color: Colors.transparent,
                    textStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  )
                )
              ]
            )
          ),
        ),
      ],
    );
  }
}