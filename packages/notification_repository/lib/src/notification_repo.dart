import 'models/models.dart';

/// An abstract class for managing notifications.
abstract class NotificationRepository {
  /// Creates a new notification.
  ///
  /// Returns the created [MyNotification] object.
	Future<MyNotification> createNotification(MyNotification notification);

  /// Retrieves the size of the notification collection.
  ///
  /// Returns the number of notifications in the collection as a double.
  Future<double> getNotificationCollectionSize();

  /// Retrieves a list of all notifications.
  ///
  /// Returns a list of [MyNotification] objects.
  Future<List<MyNotification>> getNotificationsList();


  /// Deletes a notification with the given [notificationId].
  ///
  /// Returns a list of [MyNotification] objects after the deletion.
  Future<List<MyNotification>> deleteNotification(String notificationId);
}