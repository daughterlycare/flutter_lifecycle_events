// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lifecycle_events/lifecycle_events.dart';
import 'package:local_auth/local_auth.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final picker = ImagePicker();

  List<String> events = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    events.add(state.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return LifecycleEventNotifier(
      onLifecycleEvent: (event) {
        events.add(event.toString());
        setState(() {});
      },
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        events.clear();
                        setState(() {});
                      },
                      child: const Text("Clear"),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        events.add("// Opening camera");
                        setState(() {});
                        await picker.pickImage(source: ImageSource.camera);
                      },
                      child: const Text("Take Image"),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        events.add("// Opening gallery");
                        setState(() {});
                        await picker.pickImage(source: ImageSource.gallery);
                      },
                      child: const Text("Pick Image"),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        events.add("// Prompting biometric");
                        setState(() {});
                        var auth = LocalAuthentication();

                        await auth.authenticate(biometricOnly: true, localizedReason: 'Test');
                      },
                      child: const Text("FaceID"),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [for (var e in events) Text(e)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
