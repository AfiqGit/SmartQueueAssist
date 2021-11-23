import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFde6262),
            Color(0xFFffb88c),
          ]
        )
      ),
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
        )
    );
  }
}