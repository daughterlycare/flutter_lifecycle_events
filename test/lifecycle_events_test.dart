import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecycle_events/lifecycle_events.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Correct LifecycleEvent is returned for expected messages', () async {
    const ec = EventChannel('au.com.daughterlycare/flutter_lifecycle_events');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockStreamHandler(ec,
        MockStreamHandler.inline(onListen: ((arguments, events) {
      // iOS events
      events.success("didBecomeActive");
      events.success("didEnterBackground");
      events.success("willEnterForeground");
      events.success("willResignActive");
      events.success("willTerminate");

      // Android events
      events.success("ON_RESUME");
      events.success("ON_STOP");
      events.success("ON_CREATE");
      events.success("ON_START");
      events.success("ON_PAUSE");
      events.success("ON_DESTROY");

      // Unknown event
      events.success("ON_FLANGOS");
    })));

    expectLater(
      LifecycleEvents().events,
      emitsInOrder([
        // iOS events
        LifecycleEvent.enteredForeground,
        LifecycleEvent.enteredBackground,
        LifecycleEvent.willEnterForeground,
        LifecycleEvent.willSwitchContext,
        LifecycleEvent.willTerminate,

        // Android events
        LifecycleEvent.enteredForeground,
        LifecycleEvent.enteredBackground,
        LifecycleEvent.willEnterForeground,
        LifecycleEvent.willEnterForeground,
        LifecycleEvent.willSwitchContext,
        LifecycleEvent.willTerminate,

        // Unknown event
        LifecycleEvent.unknown,
      ]),
    );
  });

  test('Correct IOSLifecycleEvent is returned for expected messages', () async {
    const ec = EventChannel('au.com.daughterlycare/flutter_lifecycle_events');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockStreamHandler(ec,
        MockStreamHandler.inline(onListen: ((arguments, events) {
      // iOS events
      events.success("didBecomeActive");
      events.success("didEnterBackground");
      events.success("willEnterForeground");
      events.success("willResignActive");
      events.success("willTerminate");

      // Android events
      events.success("ON_RESUME");
      events.success("ON_STOP");
      events.success("ON_CREATE");
      events.success("ON_START");
      events.success("ON_PAUSE");
      events.success("ON_DESTROY");

      // Unknown event
      events.success("ON_FLANGOS");
    })));

    expectLater(
      LifecycleEvents().iOS,
      emitsInOrder([
        // iOS events
        IOSLifecycleEvent.didBecomeActive,
        IOSLifecycleEvent.didEnterBackground,
        IOSLifecycleEvent.willEnterForeground,
        IOSLifecycleEvent.willResignActive,
        IOSLifecycleEvent.willTerminate,
      ]),
    );
  });

  test('Correct AndroidLifecycleEvent is returned for expected messages', () async {
    const ec = EventChannel('au.com.daughterlycare/flutter_lifecycle_events');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockStreamHandler(ec,
        MockStreamHandler.inline(onListen: ((arguments, events) {
      // iOS events
      events.success("didBecomeActive");
      events.success("didEnterBackground");
      events.success("willEnterForeground");
      events.success("willResignActive");
      events.success("willTerminate");

      // Android events
      events.success("ON_CREATE");
      events.success("ON_START");
      events.success("ON_RESUME");
      events.success("ON_PAUSE");
      events.success("ON_STOP");
      events.success("ON_DESTROY");

      // Unknown event
      events.success("ON_FLANGOS");
    })));

    expectLater(
      LifecycleEvents().android,
      emitsInOrder([
        AndroidLifecycleEvent.onCreate,
        AndroidLifecycleEvent.onStart,
        AndroidLifecycleEvent.onResume,
        AndroidLifecycleEvent.onPause,
        AndroidLifecycleEvent.onStop,
        AndroidLifecycleEvent.onDestroy,
      ]),
    );
  });
}
