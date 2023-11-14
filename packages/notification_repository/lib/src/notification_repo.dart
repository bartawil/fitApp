import 'models/models.dart';

abstract class NotificationRepository {

	Future<Notification> createNotification(Notification post);

	Future<List<Notification>> getNotification();

}