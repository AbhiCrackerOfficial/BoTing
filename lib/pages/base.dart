import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:boting/pages/mainscreen.dart';
import 'package:boting/widgets/functions.dart';
import 'package:boting/pages/chats.dart';
import 'package:boting/pages/profilescreen.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});
  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  int selectedIndex = 0;
  final List<String> _screens = ["StartScreen", "ChatScreen", "ProfileScreen"];

  final PageController pageController = PageController(initialPage: 0);
  void onItemTapped(int index) {
    setState(() {
      // manage the page
      pageController.jumpToPage(index);
      selectedIndex = index;
      switchScreen(_screens[index]);
    });
  }

  var activeScreen = 'StartScreen';

  void switchScreen(String screenName) {
    setState(() {
      activeScreen = screenName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('BoTing',
              style: GoogleFonts.josefinSans(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          backgroundColor: hexToColor('#858585'),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            selectedItemColor: hexToColor('#222222'),
            unselectedItemColor: hexToColor('#ffffff'),
            backgroundColor: hexToColor('#858585'),
            iconSize: 25,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_sharp),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_sharp),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_sharp),
                label: 'Profile',
              ),
            ],
            currentIndex: selectedIndex, // Set the current selected index
            onTap: onItemTapped,
          ),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          children: const [
            MainScreen(),
            ChatScreen(),
            ProfileScreen(),
          ],
        ));
  }
}
