import 'package:flutter/material.dart';

class RequeteFilterBar
    extends StatelessWidget {

  const RequeteFilterBar({
    super.key,
  });

  Widget filter(String title) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        boxShadow: [

          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Text(title),

          const SizedBox(width: 8),

          const Icon(
            Icons.keyboard_arrow_down,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding:
          const EdgeInsets.all(20),

      child: Wrap(

        spacing: 15,

        runSpacing: 15,

        children: [

          filter("Niveau"),

          filter("Filière"),

          filter("UE"),

          filter("Type"),
        ],
      ),
    );
  }
}