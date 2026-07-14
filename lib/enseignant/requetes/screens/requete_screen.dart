import 'package:flutter/material.dart';

import '../controllers/requete_controller.dart';

import '../widgets/requete_filter_bar.dart';
import '../widgets/requete_list.dart';
import '../widgets/requete_details.dart';

class RequeteScreen
    extends StatefulWidget {

  const RequeteScreen({
    super.key,
  });

  @override
  State<RequeteScreen>
      createState() =>
          _RequeteScreenState();
}

class _RequeteScreenState
    extends State<RequeteScreen> {

  final controller =
      RequeteController();

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(25),

      child: Column(

        children: [

          // 🔥 FILTERS
          const RequeteFilterBar(),

          Expanded(

            child: Row(

              children: [

                // 🔥 LEFT
                Expanded(

                  flex: 2,

                  child: RequeteList(

                    requetes:
                        controller
                            .state
                            .requetes,

                    onSelect: (requete) {

                      setState(() {

                        controller
                            .selectRequete(
                          requete,
                        );
                      });
                    },
                  ),
                ),

                // 🔥 RIGHT
                Expanded(

                  flex: 3,

                  child: RequeteDetails(

                    requete:
                        controller
                            .state
                            .selectedRequete,
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