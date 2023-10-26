import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/weight_bloc/weight_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

class WeightList extends StatefulWidget {
  final List<Weight> weightList;
  final String userId;

  const WeightList({Key? key, required this.weightList, required this.userId})
      : super(key: key);

  @override
  State<WeightList> createState() => _WeightListState();
}

class _WeightListState extends State<WeightList> {
  @override
  Widget build(BuildContext context) {
    // Sort the weightList by date
    widget.weightList.sort((a, b) => b.date.compareTo(a.date));
    // Get the latest weight
    Weight? latestWeight = widget.weightList.isNotEmpty ? widget.weightList.first : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.weightList.length,
            itemBuilder: (context, int i) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0.0, vertical: 1.0),
                child: Slidable(
                  endActionPane: ActionPane(
                    extentRatio: 0.2,
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          if (latestWeight?.id == widget.weightList[i].id) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text('You cannot delete the latest weight!'),
                                );
                              },
                            );
                          } else {
                            context.read<WeightBloc>().add(DeleteWeight(widget.userId, widget.weightList[i].id));
                          }
                        },
                        icon: Icons.delete,
                        backgroundColor: Colors.red
                      )
                    ]
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 0.5,
                        ),
                        right: BorderSide(
                          color: Colors.grey[300]!,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0), // Increase the vertical padding.
                      title: Padding(
                        padding: const EdgeInsets.only(
                            bottom:
                                8.0), // Add padding to the bottom of the title.
                        child: Text(
                          '${widget.weightList[i].weight} kg',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(DateFormat('dd.MM.yyyy')
                            .format(widget.weightList[i].date)),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
