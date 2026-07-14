import 'package:flutter/material.dart';

import '../../config_globale/theme/app_color.dart';
import '../../config_globale/theme/auth_left_style.dart';
import '../../config_globale/theme/form_style.dart';
import '../../config_globale/theme/screen_background_style.dart';
import '../../config_globale/theme/screen_card_style.dart';

import '../../services/api_service.dart';

import '../controllers/register_controller.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final controller =
        RegisterController(ApiService());

    return Scaffold(

      body: Container(

        width: double.infinity,
        height: double.infinity,

        decoration:
            ScreenBackgroundStyle.backgroundDecoration(),

        child: Stack(

          children: [

            // 🔥 CERCLE HAUT GLOBAL
            Positioned(

              top: -120,
              right: -100,

              child: Container(

                width: 320,
                height: 320,

                decoration: BoxDecoration(

                  color: Colors.blue.withOpacity(0.05),

                  shape: BoxShape.circle,
                ),
              ),
            ),

            // 🔥 CERCLE BAS GLOBAL
            Positioned(

              bottom: -100,
              left: -80,

              child: Container(

                width: 260,
                height: 260,

                decoration: BoxDecoration(

                  color: Colors.indigo.withOpacity(0.04),

                  shape: BoxShape.circle,
                ),
              ),
            ),

            // 🔥 CONTENU PRINCIPAL
            Center(

              child: Container(

                width: 1050,
                height: 620,

                margin: EdgeInsets.all(20),

                // 🔥 STYLE SÉPARÉ
                decoration:
                    ScreenCardStyle.cardDecoration(),

                child: ClipRRect(

                  borderRadius: BorderRadius.circular(40),

                  child: Row(

                    children: [

                      // 🔥 PARTIE GAUCHE
                      Expanded(

                        flex: 4,

                        child: Stack(

                          children: [

                            // 🔥 FOND
                            Container(

                              decoration:
                                  AuthLeftStyle.leftDecoration(),
                            ),

                            // 🔥 GRAND CERCLE HAUT
                            Positioned(

                              top: -90,
                              left: -90,

                              child: Container(

                                width: 240,
                                height: 240,

                                decoration: BoxDecoration(

                                  color:
                                      Colors.white.withOpacity(0.08),

                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),

                            // 🔥 CERCLE MILIEU
                            Positioned(

                              top: 220,
                              right: -70,

                              child: Container(

                                width: 180,
                                height: 180,

                                decoration: BoxDecoration(

                                  color:
                                      Colors.white.withOpacity(0.06),

                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),

                            // 🔥 CERCLE BAS
                            Positioned(

                              bottom: -50,
                              left: 80,

                              child: Container(

                                width: 160,
                                height: 160,

                                decoration: BoxDecoration(

                                  color:
                                      Colors.white.withOpacity(0.05),

                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),

                            // 🔥 CONTENU
                            Padding(

                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 35,
                              ),

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [

                                  Container(

                                    padding: EdgeInsets.all(18),

                                    decoration: BoxDecoration(

                                      color: Colors.white24,

                                      borderRadius:
                                          BorderRadius.circular(22),
                                    ),

                                    child: Icon(
                                      Icons.school,
                                      color: Colors.white,
                                      size: 55,
                                    ),
                                  ),

                                  SizedBox(height: 30),

                                  Text(

                                    "Université\nNumérique",

                                    style: TextStyle(

                                      color: Colors.white,

                                      fontSize: 38,

                                      fontWeight: FontWeight.bold,

                                      height: 1.2,
                                    ),
                                  ),

                                  SizedBox(height: 20),

                                  Text(

                                    "Plateforme moderne de gestion académique des étudiants.",

                                    style: TextStyle(

                                      color: Colors.white70,

                                      fontSize: 16,

                                      height: 1.6,
                                    ),
                                  ),

                                  SizedBox(height: 35),

                                  featureItem(
                                    "Inscription rapide",
                                  ),

                                  SizedBox(height: 15),

                                  featureItem(
                                    "Gestion intelligente",
                                  ),

                                  SizedBox(height: 15),

                                  featureItem(
                                    "Architecture moderne",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 🔥 PARTIE DROITE
                      Expanded(

                        flex: 5,

                        child: Container(

                          padding: EdgeInsets.all(30),

                          decoration:
                              FormStyle.formDecoration(),

                          child: RegisterForm(
                            controller: controller,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget featureItem(String text) {

    return Row(

      children: [

        Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 20,
        ),

        SizedBox(width: 10),

        Text(

          text,

          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}