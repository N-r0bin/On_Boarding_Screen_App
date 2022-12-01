import 'package:flutter/material.dart';
import 'package:on_boarding_screen/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/tree.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors:[
              Colors.black12,
              Colors.black12,
            ],
          ),
          ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Home Tree'),
            actions: [
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', false);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OnBoardingScreen()),
                    );
                  }
              ),
            ],
          ),
          body: Container(
            alignment: Alignment.center,
              padding: EdgeInsets.all(32),

          ),
        ),
      ),
      );
  }
}