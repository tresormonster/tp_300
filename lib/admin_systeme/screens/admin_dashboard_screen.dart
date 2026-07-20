import 'package:flutter/material.dart';

import '../controllers/admin_sidebar_controller.dart';

import '../controllers/admin_dashboard_controller.dart';

import '../widgets/admin_topbar.dart';

import '../widgets/admin_menu.dart';

import '../widgets/admin_body.dart';

import '../importation/screens/import_etudiant_screen.dart';
import '../pages/historique_imports_page.dart';

// 🔥 NOUVELLES PAGES
import '../pages/enseignants_page.dart';

import '../pages/ue_page.dart';

import '../pages/enseignements_page.dart';
import '../gestion_anonymat/views/anonymats_page.dart';

import '../../authentiification/services/token_service.dart';
import '../../routes/app_routes.dart';

class AdminDashboardScreen
    extends StatefulWidget {

  const AdminDashboardScreen({

    super.key,
  });

  @override
  State<AdminDashboardScreen>
      createState() =>
          _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen> {

  final sidebarController =
      AdminSidebarController();

  final dashboardController =
      AdminDashboardController();

  // 🔥 PAGE DYNAMIQUE
  Widget currentPage() {

    switch (

      dashboardController
          .state
          .currentPage
    ) {

      // 🔥 ACCES
      case "acces":

        return const Center(

          child: Text(

            "Gestion des accès",

            style: TextStyle(
              fontSize: 28,
            ),
          ),
        );

      // 🔥 USERS
      // 🔥 HISTORIQUE IMPORTS
case "historique_imports":

  return const HistoriqueImportsPage();

      // 🔥 ENSEIGNANTS
      case "enseignants":

        return const EnseignantsPage();

        

      // 🔥 UE
      case "ues":

        return const UesPage();

      // 🔥 ENSEIGNEMENTS
      case "enseignements":

        return const EnseignementsPage();

        // 🔥 ANONYMATS
case "anonymats":

  return const AnonymatsPage();

      // 🔥 IMPORT
      case "import":

        return const ImportEtudiantScreen();

      // 🔥 HOME
      default:

        return const AdminBody();
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

          // 🔥 MAIN CONTENT
          Column(

            children: [

              // 🔥 TOPBAR
              AdminTopbar(

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

                        Color(0xFFF4FBF6),

                        Color(0xFFE8F5EC),
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

          // 🔥 FLOATING MENU
          if (showMenu)

            Positioned(

              top: 105,

              left: 20,

              child: Material(

                color: Colors.transparent,

                child: AdminMenu(

                  showMenu: showMenu,

                  onSelectPage: (page) async {

  if (page == "logout") {

    await TokenService.clearSession();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );

    return;
  }

  setState(() {

    dashboardController.changePage(page);

    sidebarController.toggleMenu();
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