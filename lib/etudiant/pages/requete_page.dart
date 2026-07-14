import 'package:flutter/material.dart';

class RequetePage extends StatefulWidget {
  const RequetePage({super.key});

  @override
  State<RequetePage> createState() =>
      _RequetePageState();
}

class _RequetePageState
    extends State<RequetePage> {

  final List<Map<String, dynamic>>
      requetes = [

    {
      "ue":
          "INF301 - Algorithmique Avancée",

      "type":
          "Erreur de calcul",

      "description":
          "La moyenne calculée ne correspond pas à la somme pondérée de mes notes.",

      "statut":
          "En traitement",

      "numero":
          "REQ-001",
    },

    {
      "ue":
          "INF303 - Réseaux Informatiques",

      "type":
          "Absence injustifiée",

      "description":
          "J'étais en mission académique le jour du CC.",

      "statut":
          "Soumise",

      "numero":
          "REQ-002",
    },
  ];

  @override
  Widget build(
    BuildContext context,
  ) {

    return SingleChildScrollView(

      padding:
          const EdgeInsets.all(25),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [

              Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: const [

                  Text(

                    "Mes requêtes",

                    style: TextStyle(

                      fontSize: 32,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(

                    "Suivi de vos contestations et demandes",

                    style: TextStyle(

                      color:
                          Colors.grey,
                    ),
                  ),
                ],
              ),

              ElevatedButton.icon(

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(
                    0xFF1E5B3A,
                  ),

                  padding:
                      const EdgeInsets
                          .symmetric(

                    horizontal: 25,

                    vertical: 18,
                  ),
                ),

                onPressed: () {},

                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),

                label: const Text(

                  "Nouvelle requête",

                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          ...requetes.map(

            (requete) => _buildCard(
              requete,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    Map<String, dynamic> requete,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 20,
      ),

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black12,

            blurRadius: 8,
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              Expanded(

                child: Text(

                  requete["ue"],

                  style:
                      const TextStyle(

                    fontSize: 24,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              _statusBadge(
                requete["statut"],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(

            "Type : ${requete["type"]}",

            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          Text(

            requete["description"],

            style: const TextStyle(
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 30),

          _timeline(
            requete["statut"],
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(
    String statut,
  ) {

    Color color =
        Colors.blue;

    if (statut ==
        "En traitement") {

      color =
          Colors.orange;
    }

    if (statut ==
        "Résolue") {

      color =
          Colors.green;
    }

    if (statut ==
        "Rejetée") {

      color =
          Colors.red;
    }

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 15,

        vertical: 8,
      ),

      decoration: BoxDecoration(

        border: Border.all(
          color: color,
        ),

        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),

      child: Text(

        statut,

        style: TextStyle(
          color: color,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }

  Widget _timeline(
    String statut,
  ) {

    return Row(

      children: [

        _step(
          true,
          "Soumise",
        ),

        _line(),

        _step(

          statut ==
                  "En traitement" ||
              statut ==
                  "Résolue" ||
              statut ==
                  "Rejetée",

          "En traitement",
        ),

        _line(),

        _step(
          statut ==
              "Résolue",
          "Résolue",
        ),

        _line(),

        _step(
          statut ==
              "Rejetée",
          "Rejetée",
        ),
      ],
    );
  }

  Widget _line() {

    return Expanded(

      child: Container(

        height: 2,

        color:
            Colors.grey.shade300,
      ),
    );
  }

  Widget _step(
    bool active,
    String label,
  ) {

    return Column(

      children: [

        CircleAvatar(

          radius: 18,

          backgroundColor:

              active

                  ? const Color(
                      0xFF1E5B3A)

                  : Colors.grey
                      .shade300,

          child: Icon(

            Icons.check,

            color:

                active

                    ? Colors.white

                    : Colors.grey,
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        Text(label),
      ],
    );
  }
}