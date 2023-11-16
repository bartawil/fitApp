import 'models/models.dart';

abstract class NotificationRepository {

	Future<MyNotification> createNotification(MyNotification notification);

  Future<double> getNotificationCollectionSize();

  Future<List<MyNotification>> getNotificationsList();

  Future<List<MyNotification>> deleteNotification(String notificationId);
}