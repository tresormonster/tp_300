import 'package:flutter/material.dart';

import '../../admin_systeme/gestion_enseignant/controllers/enseignant_controller.dart';

import '../../admin_systeme/gestion_enseignant/models/enseignant_model.dart';

class EnseignantsPage extends StatefulWidget {
  const EnseignantsPage({super.key});

  @override
  State<EnseignantsPage> createState() => _EnseignantsPageState();
}

class _EnseignantsPageState extends State<EnseignantsPage> {
  final controller = EnseignantController();

  List<EnseignantModel> enseignants = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    charger();
  }



  Future<void> modifier(
  EnseignantModel ens,
) async {

  final nomController =
      TextEditingController(
    text: ens.nom,
  );

  final prenomController =
      TextEditingController(
    text: ens.prenom,
  );

  final emailController =
      TextEditingController(
    text: ens.email,
  );

  final passwordController =
      TextEditingController();

  showDialog(

    context: context,

    builder: (_) {

      return AlertDialog(

        title: const Text(
          "Modifier Enseignant",
        ),

        content:
            SingleChildScrollView(

          child: Column(

            mainAxisSize:
                MainAxisSize.min,

            children: [

              TextField(
                controller:
                    nomController,
                decoration:
                    const InputDecoration(
                  labelText: "Nom",
                ),
              ),

              TextField(
                controller:
                    prenomController,
                decoration:
                    const InputDecoration(
                  labelText:
                      "Prénom",
                ),
              ),

              TextField(
                controller:
                    emailController,
                decoration:
                    const InputDecoration(
                  labelText:
                      "Email",
                ),
              ),

              TextField(
                controller:
                    passwordController,

                obscureText:
                    true,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Nouveau mot de passe (optionnel)",
                ),
              ),
            ],
          ),
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(
                context,
              );
            },

            child:
                const Text(
              "Annuler",
            ),
          ),

          ElevatedButton(

            onPressed: () async {

              final updated =
                  EnseignantModel(

                idEnseignant:
                    ens.idEnseignant,

                nom:
                    nomController.text,

                prenom:
                    prenomController.text,

                email:
                    emailController.text,

                motDePasse:
                    passwordController
                            .text
                            .trim()
                            .isEmpty
                        ? ens.motDePasse
                        : passwordController
                            .text,
              );

              final ok =
                  await controller
                      .modifierEnseignant(

                ens.idEnseignant!,

                updated,
              );

              if (ok) {

                if (mounted) {

                  Navigator.pop(
                    context,
                  );
                }

                charger();
              }
            },

            child:
                const Text(
              "Enregistrer",
            ),
          ),
        ],
      );
    },
  );
}

  Future<void> charger() async {
    final data = await controller.chargerEnseignants();

    setState(() {
      enseignants = data;

      loading = false;
    });
  }

  Future<void> ajouter() async {
    final nomController = TextEditingController();

    final prenomController = TextEditingController();

    final emailController = TextEditingController();

    final passwordController = TextEditingController();

    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text("Nouvel Enseignant"),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                TextField(
                  controller: nomController,

                  decoration: const InputDecoration(labelText: "Nom"),
                ),

                TextField(
                  controller: prenomController,

                  decoration: const InputDecoration(labelText: "Prénom"),
                ),

                TextField(
                  controller: emailController,

                  decoration: const InputDecoration(labelText: "Email"),
                ),

                TextField(
                  controller: passwordController,

                  obscureText: true,

                  decoration: const InputDecoration(labelText: "Mot de passe"),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Annuler"),
            ),

            ElevatedButton(
              onPressed: () async {
                if (nomController.text.trim().isEmpty ||
                    prenomController.text.trim().isEmpty ||
                    emailController.text.trim().isEmpty ||
                    passwordController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Tous les champs sont obligatoires"),
                    ),
                  );

                  return;
                }

                if (!emailController.text.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Email invalide")),
                  );

                  return;
                }

                if (passwordController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Mot de passe minimum 6 caractères"),
                    ),
                  );

                  return;
                }

                final enseignant = EnseignantModel(
                  nom: nomController.text,

                  prenom: prenomController.text,

                  email: emailController.text,

                  motDePasse: passwordController.text,
                );

                final ok = await controller.ajouterEnseignant(enseignant);

                if (ok) {
                  if (mounted) {
                    Navigator.pop(context);
                  }

                  charger();
                }
              },

              child: const Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }

  Future<void> supprimer(int id) async {
    await controller.supprimerEnseignant(id);

    charger();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(25),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              const Text(
                "Gestion Enseignants",

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              ElevatedButton.icon(
                onPressed: ajouter,

                icon: const Icon(Icons.add),

                label: const Text("Ajouter"),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: enseignants.length,

              itemBuilder: (_, index) {
                final ens = enseignants[index];

                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),

                    title: Text("${ens.nom} ${ens.prenom}"),

                    subtitle: Text(ens.email),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),

                          onPressed: () {
                            modifier(ens);
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),

                          onPressed: () {
                            supprimer(ens.idEnseignant!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
