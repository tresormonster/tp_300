import 'package:flutter/material.dart';

class ScreenBackgroundStyle {

  static BoxDecoration backgroundDecoration() {

    return BoxDecoration(

      gradient: LinearGradient(

        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

        colors: [

          Color(0xFF0F172A),
          Color(0xFF111827),
          Color(0xFF1E293B),
        ],
      ),
    );
  }

  // 🔥 FORME FOND 1
  static Widget blob1() {

    return Positioned(

      top: -120,
      left: -100,

      child: Container(

        width: 350,
        height: 350,

        decoration: BoxDecoration(

          color: Color(0xFF2563EB).withOpacity(0.15),

          borderRadius: BorderRadius.only(

            topLeft: Radius.circular(200),
            topRight: Radius.circular(120),
            bottomLeft: Radius.circular(140),
            bottomRight: Radius.circular(220),
          ),
        ),
      ),
    );
  }

  // 🔥 FORME FOND 2
  static Widget blob2() {

    return Positioned(

      bottom: -140,
      right: -80,

      child: Container(

        width: 420,
        height: 420,

        decoration: BoxDecoration(

          color: Color(0xFF06B6D4).withOpacity(0.12),

          borderRadius: BorderRadius.only(

            topLeft: Radius.circular(240),
            topRight: Radius.circular(140),
            bottomLeft: Radius.circular(180),
            bottomRight: Radius.circular(260),
          ),
        ),
      ),
    );
  }

  // 🔥 FORME FOND 3
  static Widget blob3() {

    return Positioned(

      top: 180,
      left: 280,

      child: Container(

        width: 180,
        height: 180,

        decoration: BoxDecoration(

          color: Colors.white.withOpacity(0.03),

          borderRadius: BorderRadius.circular(80),
        ),
      ),
    );
  }
}