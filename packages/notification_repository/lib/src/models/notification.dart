import '../entities/entities.dart';

class Notification {
  String notificationId;
  String title;
  String description;
  DateTime dateTime;
  bool? repeatWeekly;
	String userId;

	Notification({
    required this.notificationId,
    required this.title,
    required this.description,
    required this.dateTime,
    this.repeatWeekly,
    required this.userId,
	});

  static final empty = Notification(
    notificationId: '',
    title: '',
    description: '',
    dateTime: DateTime.now(),
    repeatWeekly: false,
    userId: '',
  );

	/// Modify Notifications parameters
	Notification copyWith({
    String? notificationId,
    String? title,
    String? description,
    DateTime? dateTime,
    bool? repeatWeekly,
    String? userId,
  }) {
    return Notification(
      notificationId: notificationId ?? this.notificationId,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      repeatWeekly: repeatWeekly ?? this.repeatWeekly,
      userId: userId ?? this.userId,
    );
  }

	/// Convenience getter to determine whether the notification is empty.
  bool get isEmpty => this == Notification.empty;

  /// Convenience getter to determine whether the current notification is not empty.
  bool get isNotEmpty => this != Notification.empty;

	NotificationEntity toEntity() {
    return NotificationEntity(
      notificationId: notificationId,
      title: title,
      description: description,
      dateTime: dateTime,
      repeatWeekly: repeatWeekly,
      userId: userId,
    );
  }

	static Notification fromEntity(NotificationEntity entity) {
    return Notification(
      notificationId: entity.notificationId,
      title: entity.title,
      description: entity.description,
      dateTime: entity.dateTime,
      repeatWeekly: entity.repeatWeekly,
      userId: entity.userId,
    );
  }

	@override
  String toString() {
    return '''Notification: {
      notificationId: $notificationId,
      title: $title,
      description: $description,
      dateTime: $dateTime,
      repeatWeekly: $repeatWeekly,
      userId: $userId,
    }''';
  }
	
}