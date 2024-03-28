import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class nextpage extends StatelessWidget {
  const nextpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('images/Animation - 1707204261987.json'),
            Text(
              'Your booking is confirmed',
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
