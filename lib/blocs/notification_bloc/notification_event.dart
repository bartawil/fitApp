part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class CreateNotification extends NotificationEvent {
	final MyNotification notification;

	const CreateNotification(this.notification);
}

class GetNotificationsSize extends NotificationEvent {
  const GetNotificationsSize();
}

class GetNotificationsList extends NotificationEvent {
  const GetNotificationsList();
}

class DeleteNotification extends NotificationEvent {
  final String id;

  const DeleteNotification(this.id);
}