import 'package:flutter/material.dart';
import 'package:flutter_apns_only/flutter_apns_only.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final connector = ApnsPushConnectorOnly();

// onLaunch gets called, when you tap on notification on a closed app
// onResume gets called, when you tap on notification with app in background
// onMessage gets called, when a new notification is received

  connector.configureApns(
    onLaunch: (message) async {
      print('Notification launched app');
    },
    onResume: (message) async {
      print('Notification tapped when in the background');
    },
    onMessage: (message) async {
      print('New notification received');
    },
  );

//Requesting user permissions
  connector.requestNotificationPermissions();

//Retreive and print device token

  connector.token.addListener(() {
    print('Token ${connector.token.value}');
  });

  connector.shouldPresent = (x) => Future.value(true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Notifications App"),
        ),
        body: Center(child: Text('Ready to receive notifcations?')),
      ),
    );
  }
}
