import 'package:flutter/material.dart';

class UploadZone
    extends StatelessWidget {

  final VoidCallback onUpload;

  const UploadZone({

    super.key,

    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onUpload,

      child: Container(

        height: 250,

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(28),

          border: Border.all(

            color:
                Colors.green.shade200,

            width: 2,
          ),

          boxShadow: [

            BoxShadow(

              color: Colors.black12,

              blurRadius: 15,
            ),
          ],
        ),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Icon(

              Icons.upload_file_rounded,

              size: 80,

              color:
                  Colors.green.shade700,
            ),

            const SizedBox(height: 20),

            Text(

              "Importer un fichier Excel",

              style: TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

                color:
                    Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 10),

            Text(

              "Cliquez pour sélectionner un fichier",

              style: TextStyle(

                color:
                    Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}