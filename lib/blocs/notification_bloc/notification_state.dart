part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();
  
  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationFailure extends NotificationState {}
final class NotificationLoading extends NotificationState {}
final class NotificationSuccess extends NotificationState {
	final MyNotification notification;

	const NotificationSuccess(this.notification);
}

final class GetNotificationsSizeFailure extends NotificationState {}
final class GetNotificationsSizeLoading extends NotificationState {}
final class GetNotificationsSizeSuccess extends NotificationState {
  final double size;

  const GetNotificationsSizeSuccess(this.size);
}

final class GetNotificationsListFailure extends NotificationState {}
final class GetNotificationsListLoading extends NotificationState {}
final class GetNotificationsListSuccess extends NotificationState {
  final List<MyNotification> notificationList;

  const GetNotificationsListSuccess(this.notificationList);
}

final class DeleteNotificationFailure extends NotificationState {}
final class DeleteNotificationLoading extends NotificationState {}
final class DeleteNotificationSuccess extends NotificationState {
  final List<MyNotification> notificationList;

  const DeleteNotificationSuccess(this.notificationList);
}
