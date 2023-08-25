part of 'lifecycle_events.dart';

enum LifecycleEvent {
  enteredForeground,
  enteredBackground,
  willEnterForeground,
  willTerminate,
  willSwitchContext,
  unknown,
}

enum IOSLifecycleEvent {
  didBecomeActive,
  didEnterBackground,
  willEnterForeground,
  willResignActive,
  willTerminate,
  unknown,
}

enum AndroidLifecycleEvent {
  onCreate,
  onStart,
  onResume,
  onPause,
  onStop,
  onDestroy,
  unknown,
}
