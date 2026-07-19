import 'package:flutter/material.dart';

class EtudiantTopbar
    extends StatelessWidget {

  final VoidCallback
      onMenuPressed;

  const EtudiantTopbar({

    super.key,

    required this.onMenuPressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Container(

      height: 135,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 25,
      ),

      decoration: const BoxDecoration(

        color: Color(0xFF1E5B3A),

        boxShadow: [

          BoxShadow(

            color: Colors.black26,

            blurRadius: 8,
          ),
        ],
      ),

      child: Row(

        children: [

          // MENU
          Container(

            width: 70,

            height: 70,

            decoration: BoxDecoration(

              color: Colors.white10,

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: IconButton(

              onPressed:
                  onMenuPressed,

              icon: const Icon(

                Icons.menu,

                size: 34,

                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 20),

          // TITRE
          Expanded(

            child: Column(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: const [

               /* Text(

                  "Espace Étudiant",

                  style: TextStyle(

                    color: Colors.white,

                    fontSize: 24,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(

                  "Consultation notes et gestion des requêtes",

                  style: TextStyle(

                    color: Colors.white70,

                    fontSize: 15,
                  ),
                ),*/
              ],
            ),
          ),

          // NOTIFICATION
          IconButton(

            onPressed: () {},

            icon: const Icon(

              Icons.notifications_none,

              color: Colors.white,

              size: 34,
            ),
          ),

          const SizedBox(width: 15),

          // PROFIL
          Row(

            children: [

              CircleAvatar(

                radius: 34,

                backgroundColor:
                    Colors.white,

                child: Icon(

                  Icons.school,

                  size: 34,

                  color:
                      Color(0xFF1E5B3A),
                ),
              ),

              const SizedBox(width: 15),

              Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: const [

                  Text(

                    "Étudiant",

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(

                    "Compte étudiant",

                    style: TextStyle(

                      color:
                          Colors.white70,

                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}