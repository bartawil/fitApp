import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/weight_bloc/weight_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:user_repository/user_repository.dart';

class WeightGraphScreen extends StatefulWidget {
  const WeightGraphScreen({super.key});

  @override
  State<WeightGraphScreen> createState() => _WeightGraphScreenState();
}

class _WeightGraphScreenState extends State<WeightGraphScreen> {
  final List<Weight> chartList = [];
  String smallestWeight = '';
  String largestWeight = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeightBloc, WeightState>(
      listener: (context, state) {
        if (state is GetWeightSuccess) {
          setState(() {
            chartList.addAll(state.weightList);
            // Sort the weightList by date
            chartList.sort((a, b) => a.date.compareTo(b.date));
            smallestWeight = chartList
                .reduce((a, b) =>
                    double.parse(a.weight) < double.parse(b.weight) ? a : b)
                .weight;
            largestWeight = chartList
                .reduce((a, b) =>
                    double.parse(a.weight) > double.parse(b.weight) ? a : b)
                .weight;
          });
        }
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          body: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Weight progress chart',
                    style: GoogleFonts.playfairDisplay(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 22,
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width / 1.5,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: chartList.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                  majorGridLines: const MajorGridLines(
                                      color: Colors.transparent),
                                  isVisible: false),
                              primaryYAxis: NumericAxis(
                                minimum:
                                    (double.parse(smallestWeight) / 10).ceil() *
                                            10 -
                                        10,
                                maximum:
                                    (double.parse(largestWeight) / 10).ceil() *
                                            10 +
                                        10,
                                isVisible: false,
                              ),
                              series: <ChartSeries>[
                                  // Renders line chart
                                  LineSeries<Weight, String>(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      dataSource: chartList,
                                      xValueMapper: (Weight data, _) =>
                                          DateFormat('d/M/y').format(data.date),
                                      yValueMapper: (Weight data, _) =>
                                          double.parse(data.weight),
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
                                        textStyle: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                      ))
                                ])),
                ),
              ],
            ),
          )),
    );
  }
}
