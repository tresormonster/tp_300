import 'package:flutter/material.dart';

class RequeteFilterBar extends StatelessWidget {
  final String niveau;
  final String filiere;
  final String ue;
  final String statut;

  final List<String> niveaux;
  final List<String> filieres;
  final List<String> ues;

  final Function(String?) onNiveauChanged;
  final Function(String?) onFiliereChanged;
  final Function(String?) onUeChanged;
  final Function(String?) onStatutChanged;

  const RequeteFilterBar({
    super.key,
    required this.niveau,
    required this.filiere,
    required this.ue,
    required this.statut,
    required this.niveaux,
    required this.filieres,
    required this.ues,
    required this.onNiveauChanged,
    required this.onFiliereChanged,
    required this.onUeChanged,
    required this.onStatutChanged,
  });

  Widget _dropdown({
    required String titre,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titre,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: const SizedBox(),
              onChanged: onChanged,
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 15,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _dropdown(
              titre: "Niveau",
              value: niveau,
              items: niveaux,
              onChanged: onNiveauChanged,
            ),
            const SizedBox(width: 15),
            _dropdown(
              titre: "Filière",
              value: filiere,
              items: filieres,
              onChanged: onFiliereChanged,
            ),
            const SizedBox(width: 15),
            _dropdown(
              titre: "UE",
              value: ue,
              items: ues,
              onChanged: onUeChanged,
            ),
            const SizedBox(width: 15),
            _dropdown(
              titre: "Statut",
              value: statut,
              items: const [
                "Toutes",
                "EN_ATTENTE",
                "RESOLUE",
                "REJETEE",
              ],
              onChanged: onStatutChanged,
            ),
          ],
        ),
      ),
    );
  }
}