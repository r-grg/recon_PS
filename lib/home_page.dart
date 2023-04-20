import 'package:flutter/material.dart';
import 'recon_page.dart';
import 'user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const <Widget>[
          FirstPage(),
          SecondPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'RECON',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'USER',
          ),
        ],
      ),
    );
  }
}


class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ReconPage(),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: UserPage(),
    );
  }
}
