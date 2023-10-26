import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/weight_entity.dart';

// ignore: must_be_immutable
class Weight extends Equatable {
  String id;
  final String weight;
  final DateTime date;

  Weight({
    required this.id,
    required this.weight,
    required this.date,
  });

  static final empty = Weight(
    id: '',
    weight: '',
    date: DateTime.now(),
  );

  Weight copyWith({
    String? id,
    String? weight,
    DateTime? date,
  }) {
    return Weight(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }

  bool get isEmpty => this == Weight.empty;

  bool get isNotEmpty => this != Weight.empty;

  WeightEntity toEntity() {
    return WeightEntity(
      id: id,
      weight: weight,
      date: date,
    );
  } 

  static Weight fromEntity(WeightEntity entity) {
    return Weight(
      id: entity.id,
      weight: entity.weight,
      date: entity.date,
    );
  }

  @override
  List<Object> get props => [id, weight, date];
}