import 'package:flutter/material.dart';
import 'package:fluttertest/src/screen/list_posts_screen.dart';
import 'package:fluttertest/src/screen/photo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const PhotoScreen(),
          ListPosts(),
        ],
      ),
      bottomNavigationBar: _bottomNavigate(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final SharedPreferences prefs = await _prefs;
          await prefs.clear();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.logout),
      ),
    );
  }

  BottomNavigationBar _bottomNavigate() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      backgroundColor: Colors.grey[300],
      selectedItemColor: Colors.blue,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      onTap: (int value) {
        // Respond to item press.

        setState(() {
          _currentIndex = value;
          pageController.animateToPage(_currentIndex,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        });
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Cámara',
          icon: Icon(Icons.camera),
        ),
        BottomNavigationBarItem(
          label: 'Posts',
          icon: Icon(Icons.list_alt),
        ),
      ],
    );
  }
}
