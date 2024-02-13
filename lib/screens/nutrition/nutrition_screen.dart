import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:fitapp/blocs/goals_bloc/goals_bloc.dart';
import 'package:fitapp/screens/nutrition/daily_goals_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:user_repository/user_repository.dart';

// ignore: must_be_immutable
class NutritionScreen extends StatefulWidget {
  String userId;
  NutritionScreen(this.userId, {super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  String calories = '2000';
  String water = '2.5';
  final List<NutritionData> data = [
    NutritionData('Protein', 120),
    NutritionData('Carbs', 100),
    NutritionData('Fat', 40),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsBloc, GoalsState>(
      builder: (context, state) {
        if (state is GetGoalsSuccess) {
          data[0] =
              NutritionData('Protein', double.parse(state.goals.protein!));
          data[1] = NutritionData('Carbs', double.parse(state.goals.carbs!));
          data[2] = NutritionData('Fat', double.parse(state.goals.fat!));
          calories = state.goals.calories!;
          water = state.goals.water!;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.background,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Goals goals = Goals.empty;
                goals = goals.copyWith(
                  calories: calories,
                  water: water,
                  carbs: data[1].value.toInt().toString(),
                  protein: data[0].value.toInt().toString(),
                  fat: data[2].value.toInt().toString(),
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => GoalsBloc(
                            userRepository: context
                                .read<AuthenticationBloc>()
                                .userRepository),
                      ),
                    ],
                    child: DailyGoalsScreen(widget.userId, goals),
                  );
                }));
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.edit_document,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            body: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 350,
                    child: SfCircularChart(
                      legend: const Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        padding: 10,
                      ),
                      series: <CircularSeries>[
                        DoughnutSeries<NutritionData, String>(
                          dataSource: data,
                          xValueMapper: (NutritionData data, _) =>
                              data.nutrient,
                          yValueMapper: (NutritionData data, _) => data.value,
                          dataLabelSettings: DataLabelSettings(
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                            labelIntersectAction: LabelIntersectAction.none,
                            connectorLineSettings: const ConnectorLineSettings(
                              type: ConnectorType.curve,
                              length: '5%',
                            ),
                          ),
                          pointColorMapper: (NutritionData data, _) {
                            if (data.nutrient == 'Protein') {
                              return const Color.fromARGB(255, 189, 227, 159);
                            } else if (data.nutrient == 'Carbs') {
                              return const Color.fromARGB(255, 202, 99, 99);
                            } else {
                              return const Color.fromARGB(255, 234, 189, 126);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 340,
                    height: 150,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(-4, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.restaurant_menu,
                              color: Theme.of(context).colorScheme.background,
                              size: 80,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Daily Calories Target:',
                                  style: GoogleFonts.caveat(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  calories,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.caveat(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 340,
                    height: 150,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 178, 210, 236),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(-4, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.water_drop_outlined,
                              color: Theme.of(context).colorScheme.background,
                              size: 80,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Water Goal:',
                                  style: GoogleFonts.caveat(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  water,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.caveat(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is GetGoalsLoading) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Goals goals = Goals.empty;
              goals = goals.copyWith(
                calories: calories,
                water: water,
                carbs: data[1].value.toInt().toString(),
                protein: data[0].value.toInt().toString(),
                fat: data[2].value.toInt().toString(),
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GoalsBloc(
                          userRepository: context
                              .read<AuthenticationBloc>()
                              .userRepository),
                    ),
                  ],
                  child: DailyGoalsScreen(widget.userId, goals),
                );
              }));
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.edit_document,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 350,
                  child: SfCircularChart(
                    legend: const Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      padding: 10,
                    ),
                    series: <CircularSeries>[
                      DoughnutSeries<NutritionData, String>(
                        dataSource: data,
                        xValueMapper: (NutritionData data, _) => data.nutrient,
                        yValueMapper: (NutritionData data, _) => data.value,
                        dataLabelSettings: DataLabelSettings(
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.outside,
                          labelIntersectAction: LabelIntersectAction.none,
                          connectorLineSettings: const ConnectorLineSettings(
                            type: ConnectorType.curve,
                            length: '5%',
                          ),
                        ),
                        pointColorMapper: (NutritionData data, _) {
                          if (data.nutrient == 'Protein') {
                            return const Color.fromARGB(255, 189, 227, 159);
                          } else if (data.nutrient == 'Carbs') {
                            return const Color.fromARGB(255, 202, 99, 99);
                          } else {
                            return const Color.fromARGB(255, 234, 189, 126);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 340,
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(-4, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.restaurant_menu,
                            color: Theme.of(context).colorScheme.background,
                            size: 80,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Daily Calories Target:',
                                style: GoogleFonts.caveat(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                calories,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.caveat(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 340,
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 178, 210, 236),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(-4, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.water_drop_outlined,
                            color: Theme.of(context).colorScheme.background,
                            size: 80,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Water Goal:',
                                style: GoogleFonts.caveat(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                water,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.caveat(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NutritionData {
  NutritionData(this.nutrient, this.value);
  final String nutrient;
  final double value;
}
