import 'package:flutter/material.dart';

class RequeteActionButtons extends StatelessWidget {

  final VoidCallback onValider;
  final VoidCallback onRefuser;

  const RequeteActionButtons({
    super.key,
    required this.onValider,
    required this.onRefuser,
  });

  Widget button({
    required String title,
    required IconData icon,
    required Color background,
    required Color textColor,
    required VoidCallback onPressed,
  }) {

    return Expanded(

      child: Container(

        height: 42,

        margin: const EdgeInsets.only(
          right: 12,
        ),

        child: ElevatedButton.icon(

          icon: Icon(
            icon,
            size: 18,
          ),

          label: Text(

            title,

            style: const TextStyle(

              fontSize: 13,

              fontWeight: FontWeight.w600,
            ),
          ),

          style: ElevatedButton.styleFrom(

            elevation: 0,

            backgroundColor: background,

            foregroundColor: textColor,

            shape: RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(16),
            ),

            padding:
                const EdgeInsets.symmetric(
              vertical: 8,
            ),
          ),

          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        button(

          title: "Valider",

          icon: Icons.check_rounded,

          background:
              const Color(0xFFE8F5EE),

          textColor:
              const Color(0xFF1B7F4C),

          onPressed: onValider,
        ),

        button(

          title: "Refuser",

          icon: Icons.close_rounded,

          background:
              const Color(0xFFFDECEC),

          textColor:
              const Color(0xFFC0392B),

          onPressed: onRefuser,
        ),

        button(

          title: "Plus d'infos",

          icon:
              Icons.info_outline_rounded,

          background:
              const Color(0xFFEAF2FF),

          textColor:
              const Color(0xFF2563EB),

          onPressed: () {},
        ),
      ],
    );
  }
}