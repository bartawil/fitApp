import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/goals_entity.dart';

/// A class representing goals information with various attributes.
// ignore: must_be_immutable
class Goals extends Equatable {
  String? id;
  final DateTime date;
  String? calories;
  String? water;
  String? protein;
  String? carbs;
  String? fat;

  /// Creates a new instance of [Goals] with the provided values.
  Goals({
    this.id,
    required this.date,
    this.calories,
    this.water,
    this.protein,
    this.carbs,
    this.fat,
  });

  /// An empty goals entry, which represents an uninitialized or empty goals record.
  static final empty = Goals(
    id: '',
    date: DateTime.now(),
    calories: '',
    water: '',
    protein: '',
    carbs: '',
    fat: '',
  );

  /// Modifies the parameters of the current [Goals] instance and returns a new instance.
  Goals copyWith({
    String? id,
    DateTime? date,
    String? calories,
    String? water,
    String? protein,
    String? carbs,
    String? fat,
  }) {
    return Goals(
      id: id ?? this.id,
      date: date ?? this.date,
      calories: calories ?? this.calories,
      water: water ?? this.water,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
    );
  }

  /// Convenience getter to determine whether the current goals entry is empty.
  bool get isEmpty => this == Goals.empty;

  /// Convenience getter to determine whether the current goals entry is not empty.
  bool get isNotEmpty => this != Goals.empty;

   /// Converts the [Goals] instance to a [GoalsEntity].
  GoalsEntity toEntity() {
    return GoalsEntity(
      id: id,
      date: date,
      calories: calories,
      water: water,
      protein: protein,
      carbs: carbs,
      fat: fat,
    );
  } 

  /// Creates a [Goals] instance from a [GoalsEntity] instance.
  static Goals fromEntity(GoalsEntity entity) {
    return Goals(
      id: entity.id,
      date: entity.date,
      calories: entity.calories,
      water: entity.water,
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
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
}