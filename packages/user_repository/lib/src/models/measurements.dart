import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/measurements_entity.dart';

/// A class representing measurements information with various attributes.
// ignore: must_be_immutable
class Measurements extends Equatable {
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


  /// Creates a new instance of [Measurements] with the provided values.
  Measurements({
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

  /// An empty measurements entry, which represents an uninitialized or empty measurements record.
  static final empty = Measurements(
    id: '',
    date: DateTime.now(),
    weight: '',
    bodyFat: '',
    neckCircumference: '',
    armCircumference: '',
    waistCircumference: '',
    hipCircumference: '',
    thighCircumference: '',
    backHand: '',
    abdomen: '',
    lowerBack: '',
    leg: '',
  );

  /// Modifies the parameters of the current [Measurements] instance and returns a new instance.
  Measurements copyWith({
    String? id,
    DateTime? date,
    String? weight,
    String? bodyFat,
    String? neckCircumference,
    String? armCircumference,
    String? waistCircumference,
    String? hipCircumference,
    String? thighCircumference,
    String? backHand,
    String? abdomen,
    String? lowerBack,
    String? leg,
  }) {
    return Measurements(
      id: id ?? this.id,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      bodyFat: bodyFat ?? this.bodyFat,
      neckCircumference: neckCircumference ?? this.neckCircumference,
      armCircumference: armCircumference ?? this.armCircumference,
      waistCircumference: waistCircumference ?? this.waistCircumference,
      hipCircumference: hipCircumference ?? this.hipCircumference,
      thighCircumference: thighCircumference ?? this.thighCircumference,
      backHand: backHand ?? this.backHand,
      abdomen: abdomen ?? this.abdomen,
      lowerBack: lowerBack ?? this.lowerBack,
      leg: leg ?? this.leg,
    );
  }

  /// Convenience getter to determine whether the current measurements entry is empty.
  bool get isEmpty => this == Measurements.empty;

  /// Convenience getter to determine whether the current measurements entry is not empty.
  bool get isNotEmpty => this != Measurements.empty;

   /// Converts the [Measurements] instance to a [MeasurementsEntity].
  MeasurementsEntity toEntity() {
    return MeasurementsEntity(
      id: id,
      date: date,
      weight: weight,
      bodyFat: bodyFat,
      neckCircumference: neckCircumference,
      armCircumference: armCircumference,
      waistCircumference: waistCircumference,
      hipCircumference: hipCircumference,
      thighCircumference: thighCircumference,
      backHand: backHand,
      abdomen: abdomen,
      lowerBack: lowerBack,
      leg: leg,
    );
  } 

  /// Creates a [Measurements] instance from a [MeasurementsEntity] instance.
  static Measurements fromEntity(MeasurementsEntity entity) {
    return Measurements(
      id: entity.id,
      date: entity.date,
      weight: entity.weight,
      bodyFat: entity.bodyFat,
      neckCircumference: entity.neckCircumference,
      armCircumference: entity.armCircumference,
      waistCircumference: entity.waistCircumference,
      hipCircumference: entity.hipCircumference,
      thighCircumference: entity.thighCircumference,
      backHand: entity.backHand,
      abdomen: entity.abdomen,
      lowerBack: entity.lowerBack,
      leg: entity.leg,
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
}