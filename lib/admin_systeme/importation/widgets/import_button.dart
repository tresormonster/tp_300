import 'package:flutter/material.dart';

class ImportButton
    extends StatelessWidget {

  final VoidCallback onImport;

  const ImportButton({

    super.key,

    required this.onImport,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: double.infinity,

      height: 58,

      child: ElevatedButton.icon(

        onPressed: onImport,

        icon: const Icon(
          Icons.cloud_upload,
        ),

        label: const Text(

          "Importer les étudiants",

          style: TextStyle(

            fontSize: 17,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        style:
            ElevatedButton.styleFrom(

          backgroundColor:
              const Color(0xFF2D6A4F),

          foregroundColor:
              Colors.white,

          elevation: 0,

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}