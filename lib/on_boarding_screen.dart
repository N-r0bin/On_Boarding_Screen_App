import 'package:flutter/material.dart';
import 'package:on_boarding_screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 30),
            Text(
              title,
              style: TextStyle(
                color: Colors.teal.shade700,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
              color: Colors.yellow.shade100,
              urlImage: 'assets/images/seed.png',
              title: 'Plant a tree',
              subtitle:
              "If you save a tree, you save a life. If you plant a tree, you plant a life.” - Trees make the environment cleaner and provide us with oxygen. They're essential for life to flourish.",
            ),
            buildPage(
              color: Colors.blue.shade100,
              urlImage: 'assets/images/growing.png',
              title: 'Grow a tree',
              subtitle:
              "If you save a tree, you save a life. If you plant a tree, you plant a life.” - Trees make the environment cleaner and provide us with oxygen. They're essential for life to flourish.",
            ),
            buildPage(
              color: Colors.green.shade100,
              urlImage: 'assets/images/trees.png',
              title: 'Trees',
              subtitle:
              "Trees are life. Let's grow trees and witness life flouring all around us and our beloved people. Let the seeds grow for our beloved futures. Grow a tree, witness life.",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1),
          ),
          primary: Colors.white,
          backgroundColor: Colors.teal.shade700,
          minimumSize: const Size.fromHeight(80),
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(fontSize: 24),
        ),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
      ):
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text('SKIP'),
              onPressed: () {
                controller.jumpToPage(2);
              },
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.teal.shade700,
                ),
                onDotClicked: (index) {
                  controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
            TextButton(
              child: const Text('NEXT'),
              onPressed: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}