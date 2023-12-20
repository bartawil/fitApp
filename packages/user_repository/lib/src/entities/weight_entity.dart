import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// A class representing weight information in a Firestore document.
class WeightEntity extends Equatable {
  final String id;
  final String weight;
  final DateTime date;

  /// Creates a new instance of [WeightEntity] with the provided values.
  const WeightEntity({
    required this.id,
    required this.weight,
    required this.date,
  });

  /// Converts the [WeightEntity] instance to a Firestore document as a map.
  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'weight': weight,
      'date': date,
    };
  }

  /// Creates a [WeightEntity] instance from a Firestore document map.
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