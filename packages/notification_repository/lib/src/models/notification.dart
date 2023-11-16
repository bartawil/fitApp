import '../entities/entities.dart';

class MyNotification {
  String notificationId;
  double serialNumber;
  String title;
  String description;
  DateTime scheduledAt;
  bool? repeatWeekly;
	String userId;

	MyNotification({
    required this.notificationId,
    required this.serialNumber,
    required this.title,
    required this.description,
    required this.scheduledAt,
    this.repeatWeekly,
    required this.userId,
	});

  static final empty = MyNotification(
    notificationId: '',
    serialNumber: 0,
    title: '',
    description: '',
    scheduledAt: DateTime.now(),
    repeatWeekly: false,
    userId: '',
  );

	/// Modify Notifications parameters
	MyNotification copyWith({
    String? notificationId,
    double? serialNumber,
    String? title,
    String? description,
    DateTime? scheduledAt,
    bool? repeatWeekly,
    String? userId,
  }) {
    return MyNotification(
      notificationId: notificationId ?? this.notificationId,
      serialNumber: serialNumber ?? this.serialNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      repeatWeekly: repeatWeekly ?? this.repeatWeekly,
      userId: userId ?? this.userId,
    );
  }

	/// Convenience getter to determine whether the notification is empty.
  bool get isEmpty => this == MyNotification.empty;

  /// Convenience getter to determine whether the current notification is not empty.
  bool get isNotEmpty => this != MyNotification.empty;

	NotificationEntity toEntity() {
    return NotificationEntity(
      notificationId: notificationId,
      serialNumber: serialNumber,
      title: title,
      description: description,
      scheduledAt: scheduledAt,
      repeatWeekly: repeatWeekly,
      userId: userId,
    );
  }

	static MyNotification fromEntity(NotificationEntity entity) {
    return MyNotification(
      notificationId: entity.notificationId,
      serialNumber: entity.serialNumber,
      title: entity.title,
      description: entity.description,
      scheduledAt: entity.scheduledAt,
      repeatWeekly: entity.repeatWeekly,
      userId: entity.userId,
    );
  }

	@override
  String toString() {
    return '''Notification: {
      notificationId: $notificationId,
      serialNumber: $serialNumber,
      title: $title,
      description: $description,
      scheduledAt: $scheduledAt,
      repeatWeekly: $repeatWeekly,
      userId: $userId,
    }''';
  }
	
}