import 'package:streamer/screen/splash_screen.dart';
import 'package:streamer/screen/home.dart';
import 'package:streamer/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamer/utils/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final MaterialColor blackColor = const MaterialColor(
    0xFF000000,
    const <int, Color>{
      50: const Color(0xFF000000),
      100: const Color(0xFF000000),
      200: const Color(0xFF000000),
      300: const Color(0xFF000000),
      400: const Color(0xFF000000),
      500: const Color(0xFF000000),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasetnow Streamer',
      color: AppStyles.primaryColorLight,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new MainScreen()
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var loggedIn = false;
  @override
  void initState() {
    super.initState();
    loadSharedPref();
  }

  void loadSharedPref() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      loggedIn = prefs.getBool('login') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadSharedPref();
    return loggedIn ? HomePage() : LoginScreen();
  }
}
