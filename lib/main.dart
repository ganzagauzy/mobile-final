import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:ganza23584/components/ThemeProvider.dart';
import 'package:ganza23584/screens/StepCounter.dart';
import 'package:ganza23584/screens/compass.dart';
import 'package:ganza23584/screens/lightsensor.dart';
import 'package:ganza23584/screens/maps.dart';
import 'package:ganza23584/screens/proximitysensor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
  await initNotifications();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      // Handle notification tap
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeNotifier.currentTheme,
      home: const MyHomePage(title: 'Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({required this.title, super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    bool isYellowTheme = themeNotifier.currentTheme == 'yellow';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.hintColor,
        title: Text(
          widget.title,
          style: TextStyle(color: theme.primaryColor),
        ),
      ),
      drawer: Drawer(
        backgroundColor: theme.hintColor,
        shadowColor: theme.hintColor,
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                "Light Sensor",
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LightSensorPage()));
              },
            ),
            ListTile(
              title: const Text("Compass"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CompassPage()));
              },
            ),
            ListTile(
              title: const Text("Step Counter"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StepCounterPage()));
              },
            ),
            ListTile(
              title: const Text("Proximity Sensor"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProximityPage()));
              },
            ),
            ListTile(
              title: const Text("Maps"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MapPage()));
              },
            ),
            ListTile(
              iconColor: theme.cardColor,
              title: const Text("Toogle Theme"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                themeNotifier.toggleTheme();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to this app',
          style: TextStyle(color: theme.hintColor),
        ),
      ),
      // floatingActionButton: _buildSpeedDial(context, themeNotifier, theme),
    );
  }

  Widget _buildSpeedDial(
      BuildContext context, ThemeNotifier themeNotifier, ThemeData theme) {
    return SpeedDial(
      icon: Icons.menu,
      activeIcon: Icons.close,
      backgroundColor: theme.hintColor,
      foregroundColor: theme.primaryColor,
      overlayColor: Colors.transparent,
      children: [
        SpeedDialChild(
          child: Icon(Icons.palette, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Toggle Theme',
          onTap: () => themeNotifier.toggleTheme(),
        ),
        SpeedDialChild(
          child: Icon(Icons.map, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Maps',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const MapPage())),
        ),
        SpeedDialChild(
          child: Icon(Icons.sensor_door, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Proximity Sensor',
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProximityPage())),
        ),
        SpeedDialChild(
          child: Icon(Icons.run_circle_outlined, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Step Counter',
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const StepCounterPage())),
        ),
        SpeedDialChild(
          child: Icon(Icons.compass_calibration_outlined,
              color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Compass',
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CompassPage())),
        ),
        SpeedDialChild(
          child: Icon(Icons.lightbulb_rounded, color: theme.primaryColor),
          backgroundColor: theme.hintColor,
          label: 'Light Sensor',
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LightSensorPage())),
        ),
      ],
    );
  }
}
