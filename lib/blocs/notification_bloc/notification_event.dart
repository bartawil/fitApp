part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

// Define an event class for creating a new notification
class CreateNotification extends NotificationEvent {
	final MyNotification notification;

	const CreateNotification(this.notification);
}

// Define an event class for getting the size of notifications
class GetNotificationsSize extends NotificationEvent {
  const GetNotificationsSize();
}

// Define an event class for getting the list of notifications
class GetNotificationsList extends NotificationEvent {
  const GetNotificationsList();
}

// Define an event class for deleting a notification
class DeleteNotification extends NotificationEvent {
  final String id;

  const DeleteNotification(this.id);
}