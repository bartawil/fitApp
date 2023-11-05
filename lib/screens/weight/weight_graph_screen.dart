import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/weight_bloc/weight_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
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
                // BMI Chart
                BlocBuilder<MyUserBloc, MyUserState>(
                  builder: (context, state) {
                    double userBMI = 0;
                    String BMIStatus = '';
                    if (state.user != null) {
                      userBMI = state.user?.bmi ?? 0;
                      if (userBMI! < 18.5) {
                        BMIStatus = 'Underweight';
                      } else if (userBMI >= 18.5 && userBMI < 25) {
                        BMIStatus = 'Normal';
                      } else if (userBMI >= 25 && userBMI < 30) {
                        BMIStatus = 'Overweight';
                      } else if (userBMI >= 30) {
                        BMIStatus = 'Obese';
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        children: [
                          Text(
                            'BMI indicator - ${userBMI.toStringAsFixed(2)}',
                            style: GoogleFonts.playfairDisplay(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '($BMIStatus)',
                            style: GoogleFonts.playfairDisplay(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SfLinearGauge(
                            interval: 0.5,
                            minimum: 13.5,
                            maximum: 35,
                            markerPointers: [
                              LinearWidgetPointer(
                                value: state.user?.bmi ?? 0,
                                offset: 22,
                                animationDuration: 1000,
                                position: LinearElementPosition.outside,
                                child: Icon(
                                  Icons.location_pin,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 25,
                                ),
                              )
                            ],
                            showTicks: false,
                            minorTicksPerInterval: 0,
                            useRangeColorForAxis: true,
                            animateAxis: false,
                            labelPosition: LinearLabelPosition.inside,
                            labelFormatterCallback: (label) {
                              if (label == '15.5') {
                                return 'Under';
                              } else if (label == '18.5') {
                                return label;
                              } else if (label == '22') {
                                return 'Normal';
                              } else if (label == '25') {
                                return label;
                              } else if (label == '27.5') {
                                return 'Over';
                              } else if (label == '30') {
                                return label;
                              } else if (label == '33') {
                                return 'Obese';
                              } else {
                                return '';
                              }
                            },
                            axisTrackStyle: const LinearAxisTrackStyle(
                              thickness: 1,
                              color: Colors.transparent,
                            ),
                            ranges: const <LinearGaugeRange>[
                              LinearGaugeRange(
                                  edgeStyle: LinearEdgeStyle.startCurve,
                                  startValue: 0,
                                  endValue: 18.5,
                                  startWidth: 20,
                                  endWidth: 20,
                                  position: LinearElementPosition.outside,
                                  color: Color.fromARGB(255, 178, 210, 236)),
                              LinearGaugeRange(
                                  startValue: 18.5,
                                  endValue: 25,
                                  startWidth: 20,
                                  endWidth: 20,
                                  position: LinearElementPosition.outside,
                                  color: Color.fromARGB(255, 189, 227, 159)),
                              LinearGaugeRange(
                                  startValue: 25,
                                  endValue: 30,
                                  startWidth: 20,
                                  endWidth: 20,
                                  position: LinearElementPosition.outside,
                                  color: Color.fromARGB(255, 234, 189, 126)),
                              LinearGaugeRange(
                                  edgeStyle: LinearEdgeStyle.endCurve,
                                  startValue: 30,
                                  endValue: 50,
                                  startWidth: 20,
                                  endWidth: 20,
                                  position: LinearElementPosition.outside,
                                  color: Color.fromARGB(255, 202, 99, 99)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 120),
                // Weight Chart
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
                                      animationDuration: 1000,
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
