import 'package:flutter/material.dart';

class EnseignantTopbar
    extends StatelessWidget {

  final VoidCallback onMenuPressed;

  const EnseignantTopbar({

    super.key,

    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      height: 95,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 30,
      ),

      decoration: const BoxDecoration(

        gradient: LinearGradient(

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [

            Color(0xFF001F54),

            Color(0xFF023E7D),
          ],
        ),
      ),

      child: Row(

        children: [

          // 🔥 MENU ICON
          GestureDetector(

            onTap: onMenuPressed,

            child: Container(

              padding:
                  const EdgeInsets.all(10),

              decoration: BoxDecoration(

                color: Colors.white
                    .withOpacity(0.08),

                borderRadius:
                    BorderRadius.circular(14),
              ),

              child: const Icon(

                Icons.menu,

                color: Colors.white,

                size: 30,
              ),
            ),
          ),

          const SizedBox(width: 25),

          // 🔥 TITLES
          const Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

            /*  Text(

               // "Dashboard Enseignant",

                style: TextStyle(

                  color: Colors.white,

                  fontSize: 22,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              SizedBox(height: 4),

              Text(

               // "Gestion académique moderne",

                style: TextStyle(

                  color: Colors.white70,

                  fontSize: 14,
                ),
              ),*/
            ],
          ),

          const Spacer(),

          // 🔥 NOTIFICATION
          IconButton(

            onPressed: () {},

            icon: const Icon(

              Icons.notifications_none,

              color: Colors.white,

              size: 30,
            ),
          ),

          const SizedBox(width: 20),

          // 🔥 PROFILE
          Row(

            children: [

   CircleAvatar(
  radius: 24,
  backgroundColor: Colors.white,
  backgroundImage: const AssetImage(
    "assets/images/avatar.png",
  ),
),
              const SizedBox(width: 12),

              const Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                 /* Text(

                    "Dr Junior",

                    style: TextStyle(

                      color: Colors.white,

                      fontWeight:
                          FontWeight.bold,

                      fontSize: 16,
                    ),
                  ),*/

                  SizedBox(height: 3),

                  /*Text(

                    "Enseignant",

                    style: TextStyle(

                      color:
                          Colors.white70,

                      fontSize: 13,
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}