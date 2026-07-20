import 'package:flutter/material.dart';

class AdminMenu
    extends StatelessWidget {

  final bool showMenu;

  final Function(String)
      onSelectPage;

  const AdminMenu({

    super.key,

    required this.showMenu,

    required this.onSelectPage,
  });

  Widget item(

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
              BorderRadius.circular(
            16,
          ),

          onTap: () {

            onSelectPage(
              page,
            );
          },

          child: Ink(

            padding:
                const EdgeInsets.symmetric(

              horizontal: 16,

              vertical: 12,
            ),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(
                16,
              ),

              boxShadow: [

                BoxShadow(

                  color:
                      Colors.black12,

                  blurRadius: 10,
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
                      const EdgeInsets.all(
                    8,
                  ),

                  decoration: BoxDecoration(

                    color:
                        Colors.green
                            .shade50,

                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                  ),

                  child: Icon(

                    icon,

                    color:
                        Colors.green
                            .shade700,
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                // 🔥 TITLE
                Text(

                  title,

                  style:
                      const TextStyle(

                    fontSize: 15,

                    fontWeight:
                        FontWeight.w600,
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
  Widget build(
    BuildContext context,
  ) {

    if (!showMenu) {

      return const SizedBox();
    }

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        // 🔥 ACCES
        item(

          Icons.lock_outline,

          "Gestion accès",

          "acces",
        ),

        // 🔥 UTILISATEURS
        item(

          Icons.people_outline,

          "Historique des imports",

          "historique_imports",
        ),

        // 🔥 ENSEIGNANTS
        item(

          Icons.person_outline,

          "Gestion enseignants",

          "enseignants",
        ),

        // 🔥 UE
        item(

          Icons.menu_book_outlined,

          "Gestion UE",

          "ues",
        ),

        // 🔥 ENSEIGNEMENTS
        item(

          Icons.school_outlined,

          "Gestion enseignements",

          "enseignements",
        ),



// 🔥 ANONYMATS
item(

  Icons.badge_outlined,

  "Gestion anonymats",

  "anonymats",
),

        // 🔥 IMPORT
        item(

          Icons.upload_file_rounded,

          "Import étudiants",

          "import",
        ),

        // 🔥 LOGOUT
        item(

          Icons.logout_rounded,

          "Déconnexion",

          "logout",
        ),
      ],
    );
  }
}