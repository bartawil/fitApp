import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

/// A custom [BlocObserver] that logs the lifecycle events of [Bloc] instances.
class SimpleBlocObserver extends BlocObserver {
  /// Called when a new [Bloc] instance is created.
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- bloc: ${bloc.runtimeType}');
  }

  /// Called when an [event] is added to a [Bloc].
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  /// Called when the state of a [Bloc] changes.
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  /// Called when a [Transition] occurs in a [Bloc].
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  /// Called when an error occurs in a [Bloc].
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  /// Called when a [Bloc] instance is closed.
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- bloc: ${bloc.runtimeType}');
  }
}
