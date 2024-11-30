import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/View/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplasState();
}

class _SplasState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen() ));
    });
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Assets/Splash.jpg',
              fit: BoxFit.cover,
              // width: width * 0.9,
              height: height * 0.5,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              "Top Headlines",
              style: GoogleFonts.anton(
                  letterSpacing: 0.6,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                  fontSize: 25),
            ),
             SizedBox(
              height: height * 0.04,
            ),
            SpinKitCircle(
              color: Colors.blue,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
