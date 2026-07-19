import 'package:flutter/material.dart';

class AdminTopbar
    extends StatelessWidget {

  final VoidCallback onMenuPressed;

  const AdminTopbar({

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

            Color(0xFF1B4332),

            Color(0xFF2D6A4F),
          ],
        ),
      ),

      child: Row(

        children: [

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

          const Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /*Text(

                "Administration Système",

                style: TextStyle(

                  color: Colors.white,

                  fontSize: 24,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),*/

              SizedBox(height: 4),

              /*Text(

                "Gestion sécurité et accès",

                style: TextStyle(

                  color: Colors.white70,

                  fontSize: 14,
                ),
              ),*/
            ],
          ),

          const Spacer(),

          IconButton(

            onPressed: () {},

            icon: const Icon(

              Icons.notifications_none,

              color: Colors.white,

              size: 30,
            ),
          ),

          const SizedBox(width: 20),

          Row(

            children: [

             CircleAvatar(
  radius: 24,
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

                  /*Text(

                    "Admin Système",

                    style: TextStyle(

                      color: Colors.white,

                      fontWeight:
                          FontWeight.bold,

                      fontSize: 16,
                    ),
                  ),*/

                  SizedBox(height: 3),

                 /* Text(

                    "Super Administrateur",

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