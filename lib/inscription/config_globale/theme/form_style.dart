import 'package:flutter/material.dart';

class FormStyle {

  static BoxDecoration formDecoration() {

    return BoxDecoration(

      color: Colors.white,

      borderRadius: BorderRadius.only(

        topRight: Radius.circular(35),
        bottomRight: Radius.circular(35),
      ),

      boxShadow: [

        BoxShadow(
          color: Colors.black12,
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
    );
  }
}