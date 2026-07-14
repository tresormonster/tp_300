import 'package:flutter/material.dart';

import '../../inscription/config_globale/theme/auth_left_style.dart';
import '../../inscription/config_globale/theme/form_style.dart';
import '../../inscription/config_globale/theme/screen_background_style.dart';
import '../../inscription/config_globale/theme/screen_card_style.dart';

import '../controlllers/login_controller.dart';
import '../services/auth_service.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller =
        LoginController(
          AuthService(),
        );

    return Scaffold(

      body: Container(

        width: double.infinity,
        height: double.infinity,

        decoration:
            ScreenBackgroundStyle
                .backgroundDecoration(),

        child: Stack(

          children: [

            // 🔥 BACKGROUND BLOBS
            ScreenBackgroundStyle.blob1(),

            ScreenBackgroundStyle.blob2(),

            ScreenBackgroundStyle.blob3(),

            // 🔥 MAIN CARD
            Center(

              child: Container(

                width: 1050,
                height: 620,

                margin: EdgeInsets.all(20),

                decoration:
                    ScreenCardStyle
                        .cardDecoration(),

                child: ClipRRect(

                  borderRadius:
                      BorderRadius.circular(40),

                  child: Row(

                    children: [

                      // 🔥 LEFT SIDE
                      Expanded(

                        flex: 4,

                        child: Stack(

                          children: [

                            Container(

                              decoration:
                                  AuthLeftStyle
                                      .leftDecoration(),
                            ),

                            Positioned(

                              top: -100,
                              left: -80,

                              child: Container(

                                width: 240,
                                height: 240,

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.white
                                          .withOpacity(0.08),

                                  borderRadius:
                                      BorderRadius.circular(200),
                                ),
                              ),
                            ),

                            Positioned(

                              bottom: -120,
                              right: -100,

                              child: Container(

                                width: 300,
                                height: 300,

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.white
                                          .withOpacity(0.05),

                                  borderRadius:
                                      BorderRadius.circular(250),
                                ),
                              ),
                            ),

                            Padding(

                              padding:
                                  EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 35,
                              ),

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [

                                  // 🔥 LOGO UNIVERSITE
                                  Container(

                                    padding:
                                        EdgeInsets.all(18),

                                    decoration:
                                        BoxDecoration(

                                      color:
                                          Colors.white24,

                                      borderRadius:
                                          BorderRadius.circular(22),
                                    ),

                                    child: Image.asset(

                                      'assets/images/universite.png',

                                      width: 90,

                                      height: 90,

                                      fit: BoxFit.contain,
                                    ),
                                  ),

                                  SizedBox(height: 30),

                                  Text(

                                    "Authentification\nSécurisée",

                                    style: TextStyle(

                                      color: Colors.white,

                                      fontSize: 38,

                                      fontWeight:
                                          FontWeight.bold,

                                      height: 1.2,
                                    ),
                                  ),

                                  SizedBox(height: 20),

                                  Text(

                                    "Connectez-vous à votre plateforme universitaire moderne.",

                                    style: TextStyle(

                                      color: Colors.white70,

                                      fontSize: 16,

                                      height: 1.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 🔥 RIGHT SIDE
                      Expanded(

                        flex: 5,

                        child: Container(

                          padding:
                              EdgeInsets.all(40),

                          decoration:
                              FormStyle
                                  .formDecoration(),

                          child: LoginForm(
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
}