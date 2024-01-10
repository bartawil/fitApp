// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// A class representing weight information in a Firestore document.
class MeasurementsEntity extends Equatable {
  String? id;
  final DateTime date;
  String? weight;
  String? bodyFat;
  String? neckCircumference;
  String? armCircumference;
  String? waistCircumference;
  String? hipCircumference;
  String? thighCircumference;
  String? backHand;
  String? abdomen;
  String? lowerBack;
  String? leg;

  /// Creates a new instance of [MeasurementsEntity] with the provided values.
  MeasurementsEntity({
    this.id,
    required this.date,
    this.weight,
    this.bodyFat,
    this.neckCircumference,
    this.armCircumference,
    this.waistCircumference,
    this.hipCircumference,
    this.thighCircumference,
    this.backHand,
    this.abdomen,
    this.lowerBack,
    this.leg,
  });

  /// Converts the [MeasurementsEntity] instance to a Firestore document as a map.
  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'date': date,
      'weight': weight,
      'bodyFat': bodyFat,
      'neckCircumference': neckCircumference,
      'armCircumference': armCircumference,
      'waistCircumference': waistCircumference,
      'hipCircumference': hipCircumference,
      'thighCircumference': thighCircumference,
      'backHand': backHand,
      'abdomen': abdomen,
      'lowerBack': lowerBack,
      'leg': leg,
    };
  }

  /// Creates a [MeasurementsEntity] instance from a Firestore document map.
  static MeasurementsEntity fromDocument(Map<String, dynamic> doc) {
    return MeasurementsEntity(
      id: doc['id'] as String,
      date: (doc['date'] as Timestamp).toDate(),
      weight: doc['weight'] as String?,
      bodyFat: doc['bodyFat'] as String?,
      neckCircumference: doc['neckCircumference'] as String?,
      armCircumference: doc['armCircumference'] as String?,
      waistCircumference: doc['waistCircumference'] as String?,
      hipCircumference: doc['hipCircumference'] as String?,
      thighCircumference: doc['thighCircumference'] as String?,
      backHand: doc['backHand'] as String?,
      abdomen: doc['abdomen'] as String?,
      lowerBack: doc['lowerBack'] as String?,
      leg: doc['leg'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    id,
    date,
    weight,
    bodyFat,
    neckCircumference,
    armCircumference,
    waistCircumference,
    hipCircumference,
    thighCircumference,
    backHand,
    abdomen,
    lowerBack,
    leg,
  ];

  @override
  String toString() {
    return '''MeasurementsEntity { 
      id: $id,
      date: $date 
      weight: $weight,
      bodyFat: $bodyFat,
      neckCircumference: $neckCircumference,
      armCircumference: $armCircumference,
      waistCircumference: $waistCircumference,
      hipCircumference: $hipCircumference,
      thighCircumference: $thighCircumference,
      backHand: $backHand,
      abdomen: $abdomen,
      lowerBack: $lowerBack,
      leg: $leg,
    }''';
  }
}