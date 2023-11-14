import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:uuid/uuid.dart';

class FirebaseNotificationRepository implements NotificationRepository {

	final notificationsCollection = FirebaseFirestore.instance.collection('notifications');

  @override
  Future<Notification> createNotification(Notification notification) async {
    try {
      notification.notificationId = const Uuid().v1();
      notification.dateTime = DateTime.now();

      await notificationsCollection
				.doc(notification.notificationId)
				.set(notification.toEntity().toDocument());

			return notification;
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

  @override
  Future<List<Notification>> getNotification() {
    try {
      return notificationsCollection
				.get()
				.then((value) => value.docs.map((e) => 
					Notification.fromEntity(NotificationEntity.fromDocument(e.data()))
				).toList());
    } catch (e) {
			rethrow;
    }
  }

}