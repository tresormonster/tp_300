import 'package:flutter/material.dart';

class AuthLeftStyle {

  static BoxDecoration leftDecoration() {

    return BoxDecoration(

      gradient: LinearGradient(

        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

        colors: [

          Color(0xFF001F54),
          Color(0xFF034078),
          Color(0xFF1282A2),
        ],
      ),

      borderRadius: BorderRadius.only(

        topLeft: Radius.circular(35),
        bottomLeft: Radius.circular(35),
      ),
    );
  }
}