part of 'lifecycle_events.dart';

Map<String, LifecycleEvent> messageToEventMapping = {
  // iOS Mappings
  "didBecomeActive": LifecycleEvent.enteredForeground,
  "didEnterBackground": LifecycleEvent.enteredBackground,
  "willEnterForeground": LifecycleEvent.willEnterForeground,
  "willResignActive": LifecycleEvent.willSwitchContext,
  "willTerminate": LifecycleEvent.willTerminate,

  // Android Mappings
  "ON_RESUME": LifecycleEvent.enteredForeground,
  "ON_STOP": LifecycleEvent.enteredBackground,
  "ON_CREATE": LifecycleEvent.willEnterForeground,
  "ON_START": LifecycleEvent.willEnterForeground,
  "ON_PAUSE": LifecycleEvent.willSwitchContext,
  "ON_DESTROY": LifecycleEvent.willTerminate,
};

Map<String, IOSLifecycleEvent> messageToIOSLifecycleEvent = {
  "didBecomeActive": IOSLifecycleEvent.didBecomeActive,
  "didEnterBackground": IOSLifecycleEvent.didEnterBackground,
  "willEnterForeground": IOSLifecycleEvent.willEnterForeground,
  "willResignActive": IOSLifecycleEvent.willResignActive,
  "willTerminate": IOSLifecycleEvent.willTerminate,
};

Map<String, AndroidLifecycleEvent> messageToAndroidLifecycleEvent = {
  "ON_CREATE": AndroidLifecycleEvent.onCreate,
  "ON_START": AndroidLifecycleEvent.onStart,
  "ON_RESUME": AndroidLifecycleEvent.onResume,
  "ON_PAUSE": AndroidLifecycleEvent.onPause,
  "ON_STOP": AndroidLifecycleEvent.onStop,
  "ON_DESTROY": AndroidLifecycleEvent.onDestroy,
};
