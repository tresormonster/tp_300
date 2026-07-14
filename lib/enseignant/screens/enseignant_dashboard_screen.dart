import 'package:flutter/material.dart';

import '../controllers/sidebar_controller.dart';
import '../controllers/dashboard_controller.dart';

import '../widgets/enseignant_topbar.dart';
import '../widgets/enseignant_menu.dart';
import '../widgets/enseignant_body.dart';
import '../gestion_note/views/notes_page.dart';

import '../requetes/screens/requete_screen.dart';

class EnseignantDashboardScreen
    extends StatefulWidget {

  const EnseignantDashboardScreen({
    super.key,
  });

  @override
  State<EnseignantDashboardScreen>
      createState() =>
          _EnseignantDashboardScreenState();
}

class _EnseignantDashboardScreenState
    extends State<EnseignantDashboardScreen> {

  final sidebarController =
      SidebarController();

  final dashboardController =
      DashboardController();

  // 🔥 PAGE ACTUELLE
  Widget currentPage() {

    switch (

      dashboardController
          .state
          .currentPage
    ) {

      // 🔥 REQUETES
      case "requete":

        return const RequeteScreen();

      // 🔥 NOTES
      case "notes":

  return const NotesPage();

        

      // 🔥 HOME
      default:

        return const EnseignantBody();
    }
  }

  @override
  Widget build(BuildContext context) {

    final showMenu =
        sidebarController
            .state
            .showMenu;

    return Scaffold(

      body: Stack(

        children: [

          // 🔥 PAGE PRINCIPALE
          Column(

            children: [

              // 🔥 TOPBAR
              EnseignantTopbar(

                onMenuPressed: () {

                  setState(() {

                    sidebarController
                        .toggleMenu();
                  });
                },
              ),

              // 🔥 BODY
              Expanded(

                child: Container(

                  decoration:
                      const BoxDecoration(

                    gradient:
                        LinearGradient(

                      begin:
                          Alignment.topLeft,

                      end:
                          Alignment
                              .bottomRight,

                      colors: [

                        Color(0xFFF5F7FB),

                        Color(0xFFEAF1FF),
                      ],
                    ),
                  ),

                  child: AnimatedPadding(

                    duration:
                        const Duration(
                      milliseconds: 250,
                    ),

                    padding:
                        EdgeInsets.only(

                      left:

                          showMenu

                              ? 220

                              : 0,
                    ),

                    child: currentPage(),
                  ),
                ),
              ),
            ],
          ),

          // 🔥 OVERLAY
          if (showMenu)

            GestureDetector(

              onTap: () {

                setState(() {

                  sidebarController
                      .toggleMenu();
                });
              },

              child: Container(

                color: Colors.black
                    .withOpacity(0.04),
              ),
            ),

          // 🔥 MENU FLOTTANT
          if (showMenu)

            Positioned(

              top: 105,

              left: 20,

              child: Material(

                color: Colors.transparent,

                child: EnseignantMenu(

                  showMenu: showMenu,

                  onSelectPage: (page) {

                    setState(() {

                      dashboardController
                          .changePage(page);

                      sidebarController
                          .toggleMenu();
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}