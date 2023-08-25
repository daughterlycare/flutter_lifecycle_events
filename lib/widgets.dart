part of 'lifecycle_events.dart';

class LifecycleEventNotifier extends StatefulWidget {
  final Widget child;

  final ValueChanged<LifecycleEvent>? onLifecycleEvent;
  final ValueChanged<IOSLifecycleEvent>? onIOSEvent;
  final ValueChanged<AndroidLifecycleEvent>? onAndroidEvent;

  const LifecycleEventNotifier({
    super.key,
    required this.child,
    this.onLifecycleEvent,
    this.onIOSEvent,
    this.onAndroidEvent,
  });

  @override
  LifecycleEventNotifierState createState() => LifecycleEventNotifierState();
}

class LifecycleEventNotifierState extends State<LifecycleEventNotifier> {
  StreamSubscription? subscription;
  StreamSubscription? iOSSubscription;
  StreamSubscription? androidSubscription;

  @override
  void initState() {
    super.initState();
    if (widget.onLifecycleEvent != null) {
      subscription = LifecycleEvents().events.listen(
        (event) {
          widget.onLifecycleEvent?.call(event);
        },
      );
    }

    if (widget.onIOSEvent != null) {
      iOSSubscription = LifecycleEvents().iOS.listen(
        (event) {
          widget.onIOSEvent?.call(event);
        },
      );
    }

    if (widget.onAndroidEvent != null) {
      androidSubscription = LifecycleEvents().android.listen(
        (event) {
          widget.onAndroidEvent?.call(event);
        },
      );
    }
  }

  @override
  void dispose() {
    subscription?.cancel();
    iOSSubscription?.cancel();
    androidSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
