import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/weight_bloc/weight_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

class WeightList extends StatefulWidget {
  // List of weight entries to display
  final List<Weight> weightList;
  // User ID associated with the weight entries
  final String userId;
 
  const WeightList({Key? key, required this.weightList, required this.userId})
      : super(key: key);

  @override
  State<WeightList> createState() => _WeightListState();
}

class _WeightListState extends State<WeightList> {
  @override
  Widget build(BuildContext context) {
    // Sort the weightList by date in descending order (latest first)
    widget.weightList.sort((a, b) => b.date.compareTo(a.date));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SlidableAutoCloseBehavior(
            child: ListView.builder(
              itemCount: widget.weightList.length,
              itemBuilder: (context, int i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 1.0),
                  child: Slidable(
                    key: ValueKey(widget.weightList[i]),
                    endActionPane: ActionPane(
                        dismissible: DismissiblePane(
                          onDismissed: () {
                            // Trigger a weight deletion event when user dismisses an entry
                            context.read<WeightBloc>().add(DeleteWeight(
                                widget.userId, widget.weightList[i].id));
                          },
                        ),
                        extentRatio: 0.2,
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              // Trigger a weight deletion event when the delete action is pressed
                              context.read<WeightBloc>().add(DeleteWeight(
                                  widget.userId, widget.weightList[i].id));
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                          )
                        ]),
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
        ),
      ],
    );
  }
}
