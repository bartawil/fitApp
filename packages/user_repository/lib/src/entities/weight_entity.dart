import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WeightEntity extends Equatable {
  final String weight;
  final DateTime date;

  const WeightEntity({
    required this.weight,
    required this.date,
  });

  Map<String, Object?> toDocument() {
    return {
      'weight': weight,
      'date': date,
    };
  }

  static WeightEntity fromDocument(Map<String, dynamic> doc) {
    return WeightEntity(
      weight: doc['weight'] as String,
      date: (doc['date'] as Timestamp).toDate(),
    );
  }

  @override
  List<Object> get props => [weight, date];

  @override
  String toString() {
    return '''WeightEntity { 
      weight: $weight, 
      date: $date 
    }''';
  }
}