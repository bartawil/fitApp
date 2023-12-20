
import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a notification entity that can be stored in Firestore.
class NotificationEntity {
  String notificationId;
  double serialNumber;
  String title;
  String description;
  DateTime scheduledAt;
  final bool? repeatWeekly;
	String userId;

  /// Creates a new instance of [NotificationEntity].
	NotificationEntity({
    required this.notificationId,
    required this.serialNumber,
    required this.title,
    required this.description,
    required this.scheduledAt,
    this.repeatWeekly,
    required this.userId,
  });
  

  /// An empty [NotificationEntity] object with default values.
  static final empty = NotificationEntity(
    notificationId: '',
    serialNumber: 0,
    title: '',
    description: '',
    scheduledAt: DateTime.now(),
    repeatWeekly: false,
    userId: '',
  );
	

  /// Converts [NotificationEntity] to a map suitable for Firestore.
	Map<String, Object?> toDocument() {
    return {
      'notificationId': notificationId,
      'serialNumber': serialNumber,
      'title': title,
      'description': description,
      'scheduledAt': scheduledAt,
      'repeatWeekly': repeatWeekly,
      'userId': userId,
    };
  }


  /// Creates a [NotificationEntity] object from a Firestore document.
	static NotificationEntity fromDocument(Map<String, dynamic> doc) {
    return NotificationEntity(
      notificationId: doc['notificationId'] as String,
      serialNumber: doc['serialNumber'] as double,
      title: doc['title'] as String,
      description: doc['description'] as String,
      scheduledAt: (doc['scheduledAt'] as Timestamp).toDate(),
      repeatWeekly: doc['repeatWeekly'] as bool?,
      userId: doc['userId'] as String,
    );
  }
	
  
	List<Object?> get props => [
    notificationId,
    serialNumber,
    title,
    description,
    scheduledAt,
    repeatWeekly,
    userId,];

	@override
  String toString() {
    return '''NotificationEntity: {
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