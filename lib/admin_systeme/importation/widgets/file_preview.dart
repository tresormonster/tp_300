import 'package:flutter/material.dart';

class FilePreview
    extends StatelessWidget {

  final String fileName;

  const FilePreview({

    super.key,

    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(

            color: Colors.black12,

            blurRadius: 10,
          ),
        ],
      ),

      child: Row(

        children: [

          Icon(

            Icons.table_chart,

            color:
                Colors.green.shade700,

            size: 45,
          ),

          const SizedBox(width: 20),

          Expanded(

            child: Text(

              fileName,

              style: const TextStyle(

                fontSize: 18,

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}