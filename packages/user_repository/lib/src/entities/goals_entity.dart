// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// A class representing weight information in a Firestore document.
class GoalsEntity extends Equatable {
  String? id;
  final DateTime date;
  String? calories;
  String? water;
  String? protein;
  String? carbs;
  String? fat;

  /// Creates a new instance of [GoalsEntity] with the provided values.
  GoalsEntity({
    this.id,
    required this.date,
    this.calories,
    this.water,
    this.protein,
    this.carbs,
    this.fat,
  });

  /// Converts the [GoalsEntity] instance to a Firestore document as a map.
  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'date': date,
      'calories': calories,
      'water': water,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }

  /// Creates a [GoalsEntity] instance from a Firestore document map.
  static GoalsEntity fromDocument(Map<String, dynamic> doc) {
    return GoalsEntity(
      id: doc['id'] as String,
      date: (doc['date'] as Timestamp).toDate(),
      calories: doc['calories'] as String,
      water: doc['water'] as String,
      protein: doc['protein'] as String,
      carbs: doc['carbs'] as String,
      fat: doc['fat'] as String,
    );
  }

  @override
  List<Object?> get props => [
    id,
    date,
    calories,
    water,
    protein,
    carbs,
    fat,
  ];

  @override
  String toString() {
    return '''GoalsEntity { 
      id: $id,
      date: $date,
      calories: $calories,
      water: $water,
      protein: $protein,
      carbs: $carbs,
      fat: $fat,
    }''';
  }
}