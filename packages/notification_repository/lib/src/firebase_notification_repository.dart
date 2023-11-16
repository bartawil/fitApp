import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:uuid/uuid.dart';

class FirebaseNotificationRepository implements NotificationRepository {

	final notificationsCollection = FirebaseFirestore.instance.collection('notifications');
  final notificationsHistoryCollection = FirebaseFirestore.instance.collection('notifications_history');

  @override
  Future<MyNotification> createNotification(MyNotification notification) async {
    try {
      notification.notificationId = const Uuid().v1();

      await notificationsCollection
				.doc(notification.notificationId)
				.set(notification.toEntity().toDocument());
      
      await notificationsHistoryCollection
        .doc(notification.notificationId)
        .set(notification.toEntity().toDocument());

			return notification;
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

  @override
  Future<List<MyNotification>> getNotificationsList() {
    try {
      log("im here", name: "repository");
      return notificationsCollection
        .get()
        .then((value) => value.docs.map((e) => 
          MyNotification.fromEntity(NotificationEntity.fromDocument(e.data()))
        ).toList());
    } catch (e) {
      log("Error in getNotificationsList: $e", name: "repository");
      rethrow;
    }
  }

  @override
  Future<double> getNotificationCollectionSize() async {
    final querySnapshot = await notificationsHistoryCollection.get();
    final double size = querySnapshot.size.toDouble();
    return size;
  }

  @override
  Future<List<MyNotification>> deleteNotification(String notificationId) async {
    try {
      await notificationsCollection.doc(notificationId).delete();
      return getNotificationsList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}