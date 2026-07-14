import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String label;

  final TextEditingController controller;

  final bool obscure;

  // 🔥 VALIDATOR
  final String? Function(String?)?
      validator;

  // 🔥 ICON
  final IconData? icon;

  const CustomTextField({

    super.key,

    required this.label,

    required this.controller,

    this.obscure = false,

    this.validator,

    this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(

      controller: controller,

      obscureText: obscure,

      validator: validator,

      decoration: InputDecoration(

        labelText: label,

        // 🔥 ICON
        prefixIcon:
            icon != null
                ? Icon(icon)
                : null,

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}