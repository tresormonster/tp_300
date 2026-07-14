import 'package:flutter/material.dart';

class ScreenCardStyle {

  static BoxDecoration cardDecoration() {

    return BoxDecoration(

      borderRadius: BorderRadius.circular(40),

      gradient: LinearGradient(

        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

        colors: [

          Color(0xFF1E293B),
          Color(0xFF0F172A),
        ],
      ),

      border: Border.all(
        color: Colors.white.withOpacity(0.08),
        width: 1,
      ),

      boxShadow: [

        BoxShadow(
          color: Colors.black.withOpacity(0.35),
          blurRadius: 35,
          offset: Offset(0, 20),
        ),
      ],
    );
  }
}