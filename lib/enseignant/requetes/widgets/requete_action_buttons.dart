import 'package:flutter/material.dart';

class RequeteActionButtons
    extends StatelessWidget {

  const RequeteActionButtons({
    super.key,
  });

  Widget button({

    required String title,

    required IconData icon,

    required Color background,

    required Color textColor,
  }) {

    return Expanded(

      child: Container(

        height: 52,

        margin:
            const EdgeInsets.only(
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

              fontSize: 15,

              fontWeight:
                  FontWeight.w600,
            ),
          ),

          style:
              ElevatedButton.styleFrom(

            elevation: 0,

            backgroundColor:
                background,

            foregroundColor:
                textColor,

            shape:
                RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(16),
            ),

            padding:
                const EdgeInsets.symmetric(
              vertical: 14,
            ),
          ),

          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        // 🔥 VALIDER
        button(

          title: "Valider",

          icon:
              Icons.check_rounded,

          background:
              const Color(0xFFE8F5EE),

          textColor:
              const Color(0xFF1B7F4C),
        ),

        // 🔥 REFUSER
        button(

          title: "Refuser",

          icon:
              Icons.close_rounded,

          background:
              const Color(0xFFFDECEC),

          textColor:
              const Color(0xFFC0392B),
        ),

        // 🔥 PLUS INFOS
        button(

          title: "Plus d'infos",

          icon:
              Icons.info_outline_rounded,

          background:
              const Color(0xFFEAF2FF),

          textColor:
              const Color(0xFF2563EB),
        ),
      ],
    );
  }
}