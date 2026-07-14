import 'package:flutter/material.dart';

class EnseignantMenu
    extends StatelessWidget {

  final bool showMenu;

  final Function(String)
      onSelectPage;

  const EnseignantMenu({

    super.key,

    required this.showMenu,

    required this.onSelectPage,
  });

  Widget menuItem(

    IconData icon,

    String title,

    String page,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      child: Material(

        color: Colors.transparent,

        child: InkWell(

          borderRadius:
              BorderRadius.circular(16),

          onTap: () {

            onSelectPage(page);
          },

          child: Ink(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),

            decoration: BoxDecoration(

              color: Colors.white
                  .withOpacity(0.95),

              borderRadius:
                  BorderRadius.circular(16),

              boxShadow: [

                BoxShadow(

                  color: Colors.black12,

                  blurRadius: 10,

                  offset:
                      const Offset(0, 4),
                ),
              ],
            ),

            child: Row(

              mainAxisSize:
                  MainAxisSize.min,

              children: [

                // 🔥 ICON
                Container(

                  padding:
                      const EdgeInsets.all(8),

                  decoration: BoxDecoration(

                    color:
                        Colors.blue.shade50,

                    borderRadius:
                        BorderRadius.circular(10),
                  ),

                  child: Icon(

                    icon,

                    color:
                        Colors.blue.shade700,

                    size: 18,
                  ),
                ),

                const SizedBox(width: 12),

                // 🔥 TEXT
                Text(

                  title,

                  style: const TextStyle(

                    fontSize: 15,

                    fontWeight:
                        FontWeight.w600,

                    color:
                        Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (!showMenu) {

      return const SizedBox();
    }

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        menuItem(

          Icons.assignment_rounded,

          "Traitement requêtes",

          "requete",
        ),

        menuItem(

          Icons.edit_note_rounded,

          "Saisir notes",

          "notes",
        ),

        menuItem(

          Icons.logout_rounded,

          "Déconnexion",

          "logout",
        ),
      ],
    );
  }
}