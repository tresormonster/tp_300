import 'package:flutter/material.dart';

class EnseignantBody
    extends StatelessWidget {

  const EnseignantBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(

      child: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [

              Color(0xFFF5F7FB),

              Color(0xFFEAF1FF),
            ],
          ),
        ),

        child: Stack(

          children: [

            // 🔥 CERCLE 1
            Positioned(

              top: -80,

              right: -80,

              child: Container(

                width: 220,
                height: 220,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  color: Colors.blue
                      .withOpacity(0.08),
                ),
              ),
            ),

            // 🔥 CERCLE 2
            Positioned(

              bottom: -100,

              left: -50,

              child: Container(

                width: 250,
                height: 250,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  color: Colors.indigo
                      .withOpacity(0.06),
                ),
              ),
            ),

            // 🔥 CERCLE 3
            Positioned(

              top: 120,

              left: 180,

              child: Container(

                width: 120,
                height: 120,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  color: Colors.blue
                      .withOpacity(0.05),
                ),
              ),
            ),

            // 🔥 CONTENU CENTRAL
            Center(

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  // 🔥 ICON
                  Container(

                    padding:
                        const EdgeInsets.all(28),

                    decoration: BoxDecoration(

                      color: Colors.white
                          .withOpacity(0.7),

                      shape: BoxShape.circle,

                      boxShadow: [

                        BoxShadow(

                          color: Colors.black12,

                          blurRadius: 20,
                        ),
                      ],
                    ),

                    /*child: Icon(

                      Icons.school_rounded,

                      size: 70,

                      color: Colors.blue.shade700,
                    ),*/
                  ),

                  const SizedBox(height: 30),

                 /* // 🔥 TITLE
                  Text(

                    "Espace Enseignant",

                    style: TextStyle(

                      fontSize: 42,

                      fontWeight:
                          FontWeight.bold,

                      color:
                          Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🔥 SUBTITLE
                  Text(

                    "Gestion moderne des notes et requêtes universitaires",

                    style: TextStyle(

                      fontSize: 17,

                      color:
                          Colors.grey.shade500,
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}