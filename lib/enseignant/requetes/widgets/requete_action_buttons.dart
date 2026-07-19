import 'package:flutter/material.dart';

class RequeteActionButtons extends StatelessWidget {
  final VoidCallback onValider;
  final VoidCallback onRefuser;

  const RequeteActionButtons({
    super.key,
    required this.onValider,
    required this.onRefuser,
  });

  Widget bouton({
    required IconData icone,
    required String texte,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(
            Icons.check,
            color: Colors.white,
            size: 22,
          ),
          label: Text(
            texte,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5EA8FF),
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onValider,
              icon: const Icon(
                Icons.check_circle_outline,
                color: Colors.white,
              ),
              label: const Text(
                "Valider",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5EA8FF),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onRefuser,
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.white,
              ),
              label: const Text(
                "Refuser",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7DB7FF),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}