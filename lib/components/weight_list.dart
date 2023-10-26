import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';
class WeightList extends StatelessWidget {
  final List<Weight> weightList;

  const WeightList({Key? key, required this.weightList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort the weightList by date
    weightList.sort((a, b) => b.date.compareTo(a.date));
    if (weightList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: weightList.length,
            itemBuilder: (context, int i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
                child: Slidable(
                  startActionPane: ActionPane(
                    extentRatio: 0.15,
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          // TODO: Edit weight
                        },
                        icon: Icons.edit,
                        backgroundColor: Colors.grey
                      )
                    ]
                  ),
                  endActionPane: ActionPane(
                    extentRatio: 0.15,
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          // TODO: Delete weight
                        },
                        icon: Icons.delete,
                        backgroundColor: Colors.red
                      )
                    ]
                  ),
                  child: ListTile(
                    title: Text(
                      '${weightList[i].weight} kg',
                      style: const TextStyle(
                          fontSize: 18),
                    ),
                    trailing: Text(DateFormat('dd.MM.yyyy').format(weightList[i].date)),
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