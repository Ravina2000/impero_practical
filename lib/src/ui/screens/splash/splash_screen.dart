import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ravina_impero_practical/src/locator/get_it_locator.dart';
import 'package:ravina_impero_practical/src/ui/screens/splash/option_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    GetItLocator.setup();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OptionScreen())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height - 100));
  }
}
