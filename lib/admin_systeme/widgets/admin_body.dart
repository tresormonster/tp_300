import 'package:flutter/material.dart';

class AdminBody
    extends StatelessWidget {

  const AdminBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: const BoxDecoration(

        gradient: LinearGradient(

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [

            Color(0xFFF4FBF6),

            Color(0xFFE8F5EC),
          ],
        ),
      ),

      child: Center(

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Container(

              padding:
                  const EdgeInsets.all(28),

              decoration: BoxDecoration(

                color: Colors.white,

                shape: BoxShape.circle,

                boxShadow: [

                  BoxShadow(

                    color: Colors.black12,

                    blurRadius: 20,
                  ),
                ],
              ),

              child: Icon(

                Icons.admin_panel_settings,

                size: 70,

                color:
                    Colors.green.shade700,
              ),
            ),

            const SizedBox(height: 30),

            Text(

              "Administration Système",

              style: TextStyle(

                fontSize: 42,

                fontWeight:
                    FontWeight.bold,

                color:
                    Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 15),

            Text(

              "Gestion des accès, utilisateurs et sauvegardes",

              style: TextStyle(

                fontSize: 17,

                color:
                    Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}