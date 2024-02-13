import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:fitapp/blocs/measurements_bloc/measurements_bloc.dart';
import 'package:fitapp/screens/user_info/add_measurements_screen.dart';
import 'package:fitapp/screens/user_info/edit_measurements_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

// ignore: must_be_immutable
class MeasurementsScreen extends StatefulWidget {
  String userId;
  MeasurementsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<MeasurementsScreen> createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends State<MeasurementsScreen> {
  List<Measurements> measurementsList = [];
  @override
  Widget build(BuildContext context) {
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
        // Add New Measurements record
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => MeasurementsBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository),
                ),
              ],
              child: AddMeasurementsScreen(userId: widget.userId),
            );
          }));
        },
        backgroundColor: Theme.of(context).colorScheme.error,
        child:
            Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondary),
      ),
      body: BlocBuilder<MeasurementsBloc, MeasurementsState>(
        builder: (context, state) {
          if (state is GetMeasurementsListSuccess) {
            measurementsList = state.measurementsList;
            measurementsList.sort((a, b) => b.date.compareTo(a.date));
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: Stack(
                children: [
                  Column(
                    children: [
                      // Title
                      Container(
                        width: 280,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'MEASUREMENTS',
                            style: GoogleFonts.caveat(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Table of measurements
                      Expanded(
                        child: ListView(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                // Table titles
                                columns: const [
                                  DataColumn(label: Text('Date')),
                                  DataColumn(label: Text('Weight')),
                                  DataColumn(label: Text('Body Fat %')),
                                  DataColumn(label: Text('Neck Circumference')),
                                  DataColumn(label: Text('Arm Circumference')),
                                  DataColumn(
                                      label: Text('Waist Circumference')),
                                  DataColumn(label: Text('Hip Circumference')),
                                  DataColumn(
                                      label: Text('Thigh Circumference')),
                                  DataColumn(label: Text('Back Hand')),
                                  DataColumn(label: Text('Abdomen')),
                                  DataColumn(label: Text('Lower Back')),
                                  DataColumn(label: Text('Leg')),
                                  DataColumn(
                                    label: Text(''),
                                  ),
                                ],
                                // Table rows
                                rows: List<DataRow>.generate(
                                  measurementsList.length,
                                  (index) => DataRow(
                                    cells: [
                                      DataCell(Text(DateFormat('dd/MM/yyyy ')
                                          .format(
                                              measurementsList[index].date))),
                                      DataCell(Text(
                                          '${measurementsList[index].weight} kg')),
                                      DataCell(Text(
                                          '${measurementsList[index].bodyFat}%')),
                                      DataCell(Text(
                                          '${measurementsList[index].neckCircumference} cm')),
                                      DataCell(Text(
                                          '${measurementsList[index].armCircumference} cm')),
                                      DataCell(Text(
                                          '${measurementsList[index].waistCircumference} cm')),
                                      DataCell(Text(
                                          '${measurementsList[index].hipCircumference} cm')),
                                      DataCell(Text(
                                          '${measurementsList[index].thighCircumference} cm')),
                                      DataCell(Text(
                                          '${measurementsList[index].backHand} cm')),
                                      DataCell(Text(
                                          '${measurementsList[index].abdomen} cm')),
                                      DataCell(Text(
                                          '${measurementsList[index].lowerBack} cm')),
                                      DataCell(Text(
                                          '${measurementsList[index].leg} cm')),
                                      DataCell(
                                        const Text(''),
                                        showEditIcon: true,
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (context) =>
                                                      MeasurementsBloc(
                                                          userRepository: context
                                                              .read<
                                                                  AuthenticationBloc>()
                                                              .userRepository),
                                                ),
                                              ],
                                              child: EditMeasurementsScreen(
                                                  userId: widget.userId,
                                                  recored:
                                                      measurementsList[index]),
                                            );
                                          }));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
