import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationEntity {
  String notificationId;
  String title;
  String description;
  final DateTime dateTime;
  final bool? repeatWeekly;
	String userId;

	NotificationEntity({
    required this.notificationId,
    required this.title,
    required this.description,
    required this.dateTime,
    this.repeatWeekly,
    required this.userId,
  });

  static final empty = NotificationEntity(
    notificationId: '',
    title: '',
    description: '',
    dateTime: DateTime.now(),
    repeatWeekly: false,
    userId: '',
  );
	

	Map<String, Object?> toDocument() {
    return {
      'notificationId': notificationId,
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'repeatWeekly': repeatWeekly,
      'userId': userId,
    };
  }

	static NotificationEntity fromDocument(Map<String, dynamic> doc) {
    return NotificationEntity(
      notificationId: doc['notificationId'] as String,
      title: doc['title'] as String,
      description: doc['description'] as String,
      dateTime: (doc['dateTime'] as Timestamp).toDate(),
      repeatWeekly: doc['repeatWeekly'] as bool?,
      userId: doc['userId'] as String,
    );
  }
	
  
	List<Object?> get props => [
    notificationId,
    title,
    description,
    dateTime,
    repeatWeekly,
    userId,];

	@override
  String toString() {
    return '''NotificationEntity: {
      notificationId: $notificationId,
      title: $title,
      description: $description,
      dateTime: $dateTime,
      repeatWeekly: $repeatWeekly,
      userId: $userId,
    }''';
  }
}