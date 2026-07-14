
import 'package:flutter/material.dart';

import '../../models/etudiant.dart';

import '../../../../../widgets_reurilisable/textfiel.dart';

import '../../validation/register_validator.dart';

import '../../../routes/app_routes.dart';

import '../controllers/register_controller.dart';

class RegisterForm extends StatefulWidget {

  final RegisterController controller;

  const RegisterForm({
    super.key,
    required this.controller,
  });

  @override
  State<RegisterForm> createState() =>
      _RegisterFormState();
}

class _RegisterFormState
    extends State<RegisterForm> {

  final _formKey =
      GlobalKey<FormState>();

  final matricule =
      TextEditingController();

  final email =
      TextEditingController();

  final password =
      TextEditingController();

  String message = "";

  bool isSuccess = false;

  void submit() async {

    if (!_formKey.currentState!
        .validate()) {

      return;
    }

    final etudiant = Etudiant(

     matricule:
    matricule.text
        .trim()
        .toUpperCase(),

      email:
          email.text.trim(),

      motDePasse:
          password.text,
    );

    bool success =
        await widget.controller
            .register(etudiant);

    setState(() {

      isSuccess = success;

      message = success

          ? "Compte activé avec succès"

          : "Erreur lors de l'activation";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Form(

      key: _formKey,

      child: LayoutBuilder(

        builder: (context, constraints) {

          return SingleChildScrollView(

            child: ConstrainedBox(

              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),

              child: IntrinsicHeight(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(

                      "Activer mon compte",

                      style: TextStyle(

                        fontSize: 34,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(

                      "Entrez votre matricule universitaire pour activer votre compte",

                      style: TextStyle(

                        color: Colors.grey,

                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 40),

                    CustomTextField(

                      label: "Matricule",

                      controller: matricule,

                      validator:
                          RegisterValidator
                              .validateMatricule,
                    ),

                    SizedBox(height: 20),

                    CustomTextField(

                      label: "Email",

                      controller: email,

                      validator:
                          RegisterValidator
                              .validateEmail,
                    ),

                    SizedBox(height: 20),

                    CustomTextField(

                      label: "Mot de passe",

                      controller: password,

                      obscure: true,

                      validator:
                          RegisterValidator
                              .validatePassword,
                    ),

                    SizedBox(height: 35),

                    SizedBox(

                      width: double.infinity,

                      height: 58,

                      child: ElevatedButton(

                        onPressed: submit,

                        child: Text(

                          "Activer le compte",

                          style: TextStyle(

                            fontSize: 16,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

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

                    Center(

                      child: Row(

                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Text(

                            "Vous avez déjà un compte ? ",

                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),

                          GestureDetector(

                            onTap: () {

                              Navigator.pushNamed(

                                context,

                                AppRoutes.login,
                              );
                            },

                            child: Text(

                              "Se connecter",

                              style: TextStyle(

                                color: Colors.blue,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}