import 'package:flutter/material.dart';

import '../../../widgets_reurilisable/textfiel.dart';

import '../../routes/app_routes.dart';

import '../../authentiification/controlllers/login_controller.dart';

import '../validation/login_validator.dart';

class LoginForm extends StatefulWidget {

  final LoginController controller;

  const LoginForm({
    super.key,
    required this.controller,
  });

  @override
  State<LoginForm> createState() =>
      _LoginFormState();
}

class _LoginFormState
    extends State<LoginForm> {

  final _formKey =
      GlobalKey<FormState>();

  final email =
      TextEditingController();

  final password =
      TextEditingController();

  String message = "";

  bool isSuccess = false;

  // 🔥 LOGIN
  void submit() async {

    if (!_formKey.currentState!
        .validate()) {

      return;
    }

    final result =
    await widget.controller.login(

      email.text,

      password.text,
    );




if (result.isSuccess) {

  if (!mounted) return;

  if (result.message ==
      "ETUDIANT") {

    Navigator.pushReplacementNamed(
  context,
  AppRoutes.etudiant,
);
    return;
  }

  if (result.message ==
      "ENSEIGNANT") {

    Navigator.pushReplacementNamed(
  context,
  AppRoutes.enseignant,
);

    return;
  }
}





    setState(() {

      

          isSuccess =
    result.isSuccess;

    message =
    result.message;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Form(

      key: _formKey,

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // 🔥 TITRE
          Text(

            "Connexion",

            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(

            "Accédez à votre espace universitaire",

            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),

          SizedBox(height: 40),

          // 🔥 EMAIL
          CustomTextField(

            label: "Email",

            icon: Icons.email_outlined,

            controller: email,

            validator:
                LoginValidator
                    .validateEmail,
          ),

          SizedBox(height: 20),

          // 🔥 PASSWORD
          CustomTextField(

            label: "Mot de passe",

            icon: Icons.lock_outline,

            controller: password,

            obscure: true,

            validator:
                LoginValidator
                    .validatePassword,
          ),

          SizedBox(height: 35),

          // 🔥 BUTTON
          SizedBox(

            width: double.infinity,
            height: 58,

            child: ElevatedButton(

              onPressed: submit,

              child: Text(

                "Se connecter",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 15),

          // 🔥 MESSAGE
          if (message.isNotEmpty)

            Center(

              child: Text(

                message,

                style: TextStyle(

                  color:

                      isSuccess
                          ? Colors.green
                          : Colors.red,

                  fontSize: 14,

                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ),

          SizedBox(height: 25),

          // 🔥 REGISTER LINK
          Center(

            child: Row(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                Text(

                  "Vous êtes étudiant et vous n’avez pas de compte ? ",

                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),

                GestureDetector(

                  onTap: () {

                    Navigator.pushNamed(

                      context,

                      AppRoutes.register,
                    );
                  },

                  child: Text(

                    "Créer un compte",

                    style: TextStyle(

                      color: Colors.blue,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}