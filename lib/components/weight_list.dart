import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('dd.MM.yyyy').format(weightList[i].date)),
                        Text(
                          weightList[i].weight,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}