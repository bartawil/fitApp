import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:uuid/uuid.dart';

/// A repository implementation for managing notifications using Firebase Firestore.
class FirebaseNotificationRepository implements NotificationRepository {
  /// The Firestore collection for storing active notifications
	final notificationsCollection = FirebaseFirestore.instance.collection('notifications');
  /// The Firestore collection for storing notifications in history.
  final notificationsHistoryCollection = FirebaseFirestore.instance.collection('notifications_history');


  /// Creates a new notification in the Firebase Firestore collections.
  /// 
  /// This method generates a unique ID for the notification, adds it to the
  /// [notification], and stores it in both the [notificationsCollection] and
  /// [notificationsHistoryCollection].
  ///
  /// Returns the created [MyNotification] object.
  ///
  /// Throws an error if the operation fails.
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

  /// Retrieves a list of all notifications from the [notificationsCollection].
  ///
  /// Returns a list of [MyNotification] objects.
  ///
  /// Throws an error if the operation fails.
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


  /// Retrieves the size of the [notificationsHistoryCollection].
  ///
  /// Returns the number of documents in the collection as a double.
  ///
  /// Throws an error if the operation fails.
  @override
  Future<double> getNotificationCollectionSize() async {
    final querySnapshot = await notificationsHistoryCollection.get();
    final double size = querySnapshot.size.toDouble();
    return size;
  }

  /// Deletes a notification with the given [notificationId] from the [notificationsCollection].
  ///
  /// Returns a list of [MyNotification] objects after the deletion.
  ///
  /// Throws an error if the operation fails.
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