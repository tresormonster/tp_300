import 'package:flutter/material.dart';

import '../../../authentiification/services/token_service.dart';

import '../controllers/requete_controller.dart';

import '../widgets/requete_filter_bar.dart';
import '../widgets/requete_list.dart';
import '../widgets/requete_details.dart';

class RequeteScreen extends StatefulWidget {
  const RequeteScreen({
    super.key,
  });

  @override
  State<RequeteScreen> createState() =>
      _RequeteScreenState();
}

class _RequeteScreenState
    extends State<RequeteScreen> {

  final controller =
      RequeteController();

  bool loading = true;

  @override
  void initState() {
    super.initState();

    charger();
  }

  Future<void> charger() async {

    final id =
        await TokenService.getId();

    if (id != null) {

      await controller
          .chargerRequetes(
        id,
      );
    }

    setState(() {

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    return Container(

      padding:
          const EdgeInsets.all(25),

      child: Column(

        children: [

          const RequeteFilterBar(),

          Expanded(

            child: Row(

              children: [

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