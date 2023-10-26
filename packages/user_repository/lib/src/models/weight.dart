import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/weight_entity.dart';

class Weight extends Equatable {
  final String weight;
  final DateTime date;

  const Weight({
    required this.weight,
    required this.date,
  });

  static final empty = Weight(
    weight: '',
    date: DateTime.now(),
  );

  Weight copyWith({
    String? weight,
    DateTime? date,
  }) {
    return Weight(
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }

  bool get isEmpty => this == Weight.empty;

  bool get isNotEmpty => this != Weight.empty;

  WeightEntity toEntity() {
    return WeightEntity(
      weight: weight,
      date: date,
    );
  } 

  static Weight fromEntity(WeightEntity entity) {
    return Weight(
      weight: entity.weight,
      date: entity.date,
    );
  }

  @override
  List<Object> get props => [weight, date];
}