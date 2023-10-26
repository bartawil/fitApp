import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WeightEntity extends Equatable {
  final String id;
  final String weight;
  final DateTime date;

  const WeightEntity({
    required this.id,
    required this.weight,
    required this.date,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'weight': weight,
      'date': date,
    };
  }

  static WeightEntity fromDocument(Map<String, dynamic> doc) {
    return WeightEntity(
      id: doc['id'] as String,
      weight: doc['weight'] as String,
      date: (doc['date'] as Timestamp).toDate(),
    );
  }

  @override
  List<Object> get props => [id, weight, date];

  @override
  String toString() {
    return '''WeightEntity { 
      id: $id,
      weight: $weight, 
      date: $date 
    }''';
  }
}