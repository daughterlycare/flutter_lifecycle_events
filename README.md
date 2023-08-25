# Flutter Lifecycle Events

An updated plugin to provide information on lifecycle events occurring in your iOS/Android app. 

This project stands on the shoulders of https://github.com/ajinasokan/flutter_fgbg.

## Why a whole new plugin?
We acknowledge the work that [@ajinasokan](https://github.com/ajinasokan) has done so far on this plugin, however there are issues with its native implementation that require a large refactor of native code.

We also wish to implement our own improved API in order to offer more flexibility and customisation for users. Some of our improvements are below:

- Hard crashes no longer occur when the FlutterEngine is detatched and reattached by the OS.
- Cross-platform lifecycle events are reported for all lifecycle events that occur on iOS and Android
- Platform specific lifecycle events are now provided for iOS and Android so that users may formulate their own mappings.
- Raw messages from native are available for users who require lower level access.

We have also extended the notifier widget from `flutter_fgbg` to provide platform-specific callbacks to users who need it.

Finally, we are committed to the ongoing maintenance of the plugin and are more than happy to take community suggestions on board.

## Getting Started
Add flutter_lifecycle_events to your `pubspec.yaml`
```
flutter pub add flutter_lifecycle_events
```

You are able to consume lifecycle events both through the included widget or by listening to the broadcast streams directly.

## Event Mapping
So that a unified lifecycle event type could be used in the plugin, it was necessary to map similar iOS and Android native lifecycle events together. The mapping we have used is below.

| flutter_lifecycle_events           | iOS                 | Android             |
|------------------------------------|---------------------|---------------------|
| LifecycleEvent.enteredForeground   | didBecomeActive     | ON_RESUME           |
| LifecycleEvent.enteredBackground   | didEnterBackground  | ON_STOP             |
| LifecycleEvent.willEnterForeground | willEnterForeground | ON_CREATE, ON_START |
| LifecycleEvent.willTerminate       | willTerminate       | ON_DESTROY          |
| LifecycleEvent.willSwitchContext   | willResignActive    | ON_PAUSE            |

> **Note**: if this mapping does not suit your use case, you are able to create a custom mapping by consuming the raw stream and returning your own events.

### Widget
---
```dart
import 'package:lifecycle_events/lifecycle_events.dart';

LifecycleEventNotifier(
    onLifecycleEvent: (event) {
        print(event); // This callback will be run on either platform when a lifecycle event is provided
    },
    onIOSEvent: (event) {
        print(event); // This callback will only run on iOS
    },
    onAndroidEvent: (event) {
        print(event); // This callback will only run on Android
    },
    child: ...,
)
```

### Stream
---
Three streams are made available by the plugin:
1. `events` will provide generic events mapped from our native events (mapping is below)
2. `iOS` will provide events sent by iOS devices only
3. `android` will provide events sent by Android devices only

We also have a fourth stream, `raw` which will provide the raw message from the native implementation in case low level API access is required.

#### Generic Lifeycle Events (most common)
```dart
import 'package:lifecycle_events/lifecycle_events.dart';

StreamSubscription<LifecycleEvent> subscription;

subscription = LifecycleEvents.events.listen((event) {
    // One of:
    // LifecycleEvent.enteredForeground
    // LifecycleEvent.enteredBackground
    // LifecycleEvent.willEnterForeground
    // LifecycleEvent.willTerminate
    // LifecycleEvent.willSwitchContext
    // LifecycleEvent.unknown
});

subscription.cancel();
```

#### Only iOS Lifeycle Events
```dart
import 'package:lifecycle_events/lifecycle_events.dart';

StreamSubscription<iOSLifecycleEvent> subscription;

subscription = LifecycleEvents.iOS.listen((event) {
    // One of:
    // IOSLifecycleEvent.didBecomeActive
    // IOSLifecycleEvent.didEnterBackground
    // IOSLifecycleEvent.willEnterForeground
    // IOSLifecycleEvent.willResignActive
    // IOSLifecycleEvent.willTerminate
    // IOSLifecycleEvent.unknown
});

subscription.cancel();
```

#### Only Android Lifeycle Events
```dart
import 'package:lifecycle_events/lifecycle_events.dart';

StreamSubscription<AndroidLifecycleEvent> subscription;

subscription = LifecycleEvents.android.listen((event) {
    // One of:
    // AndroidLifecycleEvent.onCreate
    // AndroidLifecycleEvent.onStart
    // AndroidLifecycleEvent.onResume
    // AndroidLifecycleEvent.onPause
    // AndroidLifecycleEvent.onStop
    // AndroidLifecycleEvent.onDestroy
    // AndroidLifecycleEvent.unknown
});

subscription.cancel();
```

#### Raw Messages (Advanced)
```dart
import 'package:lifecycle_events/lifecycle_events.dart';

StreamSubscription<dynamic> subscription;

subscription = LifecycleEvents.raw.listen((event) {
    // This event will contain the string sent back from native code.
});

subscription.cancel();
```

