import 'package:boting/db/connect.dart';
import 'package:boting/db/models/message.dart';
import 'package:boting/db/models/room.dart';
import 'package:boting/db/user_functions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:boting/pages/base.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:boting/data/theme_data.dart';
import 'package:page_transition/page_transition.dart';
import 'db/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await Hive.initFlutter();
  registerAdapters();
  await dotenv.load(fileName: "assets/.env");
  await Hive.openBox<User>('userBox');
  await Hive.openBox<Room>('RoomBox');
  await Hive.openBox<Message>('MessageBox');
  server.connect();
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoTing',
      theme:  MediaQuery.of(context).platformBrightness == Brightness.dark
          ? darkTheme
          : lightTheme,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/images/final.png',
        ),
        nextScreen: const ScreenManager(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.black,
        animationDuration: const Duration(milliseconds: 1500),
        duration: 2000,
        splashIconSize: 200,
        centered: true,
      ),
    );
  }
}
