part of 'lifecycle_events.dart';

class LifecycleEvents {
  static final LifecycleEvents _instance = LifecycleEvents._internal();

  factory LifecycleEvents() {
    return _instance;
  }

  LifecycleEvents._internal();

  static const _channel = EventChannel("au.com.daughterlycare/flutter_lifecycle_events");

  static Stream<dynamic> get raw => _channel.receiveBroadcastStream();

  Stream<LifecycleEvent> get events =>
      raw.map((event) => messageToEventMapping[event] ?? LifecycleEvent.unknown).asBroadcastStream();

  Stream<IOSLifecycleEvent> get iOS => raw
      .where((event) => messageToIOSLifecycleEvent.keys.contains(event))
      .map((event) => messageToIOSLifecycleEvent[event] ?? IOSLifecycleEvent.unknown)
      .asBroadcastStream();

  Stream<AndroidLifecycleEvent> get android => raw
      .where((event) => messageToAndroidLifecycleEvent.keys.contains(event))
      .map((event) => messageToAndroidLifecycleEvent[event] ?? AndroidLifecycleEvent.unknown)
      .asBroadcastStream();
}
