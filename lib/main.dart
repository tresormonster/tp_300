import 'package:flutter/material.dart';

import 'authentiification/screens/login_screen.dart';

import 'inscription/module/screens/register_screen.dart';

import 'enseignant/screens/enseignant_dashboard_screen.dart';

import 'admin_systeme/screens/admin_dashboard_screen.dart';
import 'etudiant/screens/etudiant_dashboard_screen.dart';

import 'routes/app_routes.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      // 🔥 PAGE TEST
      initialRoute:
          AppRoutes.login,

      routes: {

        // 🔥 LOGIN
        AppRoutes.login:
            (context) =>
                LoginScreen(),

        // 🔥 REGISTER
        AppRoutes.register:
            (context) =>
                RegisterScreen(),

        // 🔥 ENSEIGNANT
        AppRoutes.enseignant:
            (context) =>
                const EnseignantDashboardScreen(),

        // 🔥 ADMIN
        AppRoutes.admin:
            (context) =>
                const AdminDashboardScreen(),

         // 🔥 ETUDIANT
        AppRoutes.etudiant:
            (context) =>
                const EtudiantDashboardScreen(),       
      },
    );
  }
}