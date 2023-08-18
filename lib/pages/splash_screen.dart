import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String loadingString = 'Loading.....';
  Duration delayInterval = const Duration(milliseconds: 10000);

  @override
  void initState() {
    gotoaPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Lottie.asset('assets/lottie/splash.json'),
            Lottie.asset('assets/lottie/loader.json'),
          ],
        ),
      ),
    );
  }

  void gotoaPage() async {
    dynamic cookie = 'something';
    if (cookie != null) {
      await Future.delayed(delayInterval);
      Future(
        () => Navigator.of(context).pushReplacementNamed('/homePage'),
      );
    }
  }
}
