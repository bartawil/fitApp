import 'models/models.dart';

abstract class NotificationRepository {

	Future<MyNotification> createNotification(MyNotification notification);

	Future<List<MyNotification>> getNotifications();

}