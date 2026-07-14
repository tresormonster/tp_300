import 'package:flutter/material.dart';

import '../controllers/etudiant_sidebar_controller.dart';

import '../controllers/etudiant_dashboard_controller.dart';

import '../widgets/etudiant_topbar.dart';

import '../widgets/etudiant_menu.dart';

import '../widgets/etudiant_body.dart';

import '../pages/notes_page.dart';

import '../pages/requete_page.dart';


class EtudiantDashboardScreen
    extends StatefulWidget {

  const EtudiantDashboardScreen({
    super.key,
  });

  @override
  State<EtudiantDashboardScreen>
      createState() =>
          _EtudiantDashboardScreenState();
}

class _EtudiantDashboardScreenState
    extends State<EtudiantDashboardScreen> {

  final sidebarController =
      EtudiantSidebarController();

  final dashboardController =
      EtudiantDashboardController();

  Widget currentPage() {

    switch (

      dashboardController
          .state
          .currentPage
    ) {

      case "notes":

        return const NotesPage();

      case "requete":

        return const RequetePage();

      default:

        return const EtudiantBody();
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final showMenu =
        sidebarController
            .state
            .showMenu;

    return Scaffold(

      body: Stack(

        children: [

          Column(

            children: [

              EtudiantTopbar(

                onMenuPressed: () {

                  setState(() {

                    sidebarController
                        .toggleMenu();
                  });
                },
              ),

              Expanded(

                child: Container(

                  decoration:
                      const BoxDecoration(

                    gradient:
                        LinearGradient(

                      begin:
                          Alignment.topLeft,

                      end:
                          Alignment.bottomRight,

                      colors: [

                        Color(
                          0xFFF4FBF6,
                        ),

                        Color(
                          0xFFE8F5EC,
                        ),
                      ],
                    ),
                  ),

                  child:
                      AnimatedPadding(

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

                    child:
                        currentPage(),
                  ),
                ),
              ),
            ],
          ),

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
                    .withOpacity(
                  0.04,
                ),
              ),
            ),

          if (showMenu)

            Positioned(

              top: 150,

              left: 20,

              child: Material(

                color:
                    Colors.transparent,

                child: EtudiantMenu(

                  showMenu:
                      showMenu,

                  onSelectPage:
                      (page) {

                    if (page ==
                        "logout") {

                      Navigator.pop(
                        context,
                      );

                      return;
                    }

                    setState(() {

                      dashboardController
                          .changePage(
                        page,
                      );

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