import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import '../controllers/import_controller.dart';

import '../services/import_service.dart';

class ImportEtudiantScreen
    extends StatefulWidget {

  const ImportEtudiantScreen({
    super.key,
  });

  @override
  State<ImportEtudiantScreen>
      createState() =>
          _ImportEtudiantScreenState();
}

class _ImportEtudiantScreenState
    extends State<ImportEtudiantScreen> {

  final controller =
      ImportController();

  final importService =
      ImportService();

  final filiereController =
      TextEditingController();

  final niveauController =
      TextEditingController();
     
      
      String? cycleSelectionne;

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Center(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(20),

          child: Container(

            width: 520,

            padding:
                const EdgeInsets.all(28),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(24),

              boxShadow: [

                BoxShadow(

                  color: Colors.black
                      .withOpacity(0.05),

                  blurRadius: 18,

                  offset:
                      const Offset(0, 8),
                ),
              ],
            ),

            child: Column(

              mainAxisSize:
                  MainAxisSize.min,

              children: [

                // 🔥 TITLE
                Text(

                  "Importation Étudiants",

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(

                    fontSize: 28,

                    fontWeight:
                        FontWeight.bold,

                    color:
                        Colors.grey.shade800,
                  ),
                ),

                const SizedBox(height: 10),

                Text(

                  "Importer une liste Excel universitaire",

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(

                    fontSize: 14,

                    color:
                        Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 28),
                                // 🔥 CYCLE
DropdownButtonFormField<String>(

  value: cycleSelectionne,

  decoration: InputDecoration(

    labelText: "Cycle",

    prefixIcon: const Icon(
      Icons.account_tree,
    ),

    border: OutlineInputBorder(

      borderRadius:
          BorderRadius.circular(
        16,
      ),
    ),
  ),

  items: const [

    DropdownMenuItem(

      value: 'licence',

      child: Text(
        'Licence',
      ),
    ),

    DropdownMenuItem(

      value: 'master',

      child: Text(
        'Master',
      ),
    ),

    DropdownMenuItem(

      value: 'doctorat',

      child: Text(
        'Doctorat',
      ),
    ),
  ],

  onChanged: (value) {

    setState(() {

      cycleSelectionne =
          value;
    });
  },
),

const SizedBox(height: 18),
                // 🔥 FILIERE
                TextField(

                  controller:
                      filiereController,

                  decoration:
                      InputDecoration(

                    labelText:
                        "Filière",

                    hintText:
                        "Ex: ICT",

                    prefixIcon:
                        const Icon(
                      Icons.school,
                    ),

                    border:
                        OutlineInputBorder(

                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // 🔥 NIVEAU
                TextField(

                  controller:
                      niveauController,

                  decoration:
                      InputDecoration(

                    labelText:
                        "Niveau",

                    hintText:
                        "Ex: M1",

                    prefixIcon:
                        const Icon(
                      Icons.layers,
                    ),

                    border:
                        OutlineInputBorder(

                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // 🔥 FILE NAME
                if (controller
                        .state
                        .fileName !=
                    null)

                  Padding(

                    padding:
                        const EdgeInsets.only(
                      bottom: 18,
                    ),

                    child: Container(

                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 14,

                        vertical: 12,
                      ),

                      decoration: BoxDecoration(

                        color:
                            const Color(
                          0xFFF4F8F5,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),

                      child: Row(

                        children: [

                          Icon(

                            Icons.description,

                            color:
                                Colors.green
                                    .shade700,
                          ),

                          const SizedBox(width: 10),

                          Expanded(

                            child: Text(

                              controller
                                  .state
                                  .fileName!,

                              overflow:
                                  TextOverflow
                                      .ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // 🔥 IMPORT ZONE
                GestureDetector(

                  onTap: () async {

                    FilePickerResult?
                        result =

                        await FilePicker
                            .platform
                            .pickFiles(

                      type:
                          FileType.custom,

                      withData: true,

                      allowedExtensions: [

                        'xlsx',

                        'xls',
                      ],
                    );

                    // 🔥 FILE SELECTED
                    if (result != null) {

                      final file =
                          result.files.first;

                      if (file.bytes != null) {

                        setState(() {

                          controller.setFile(

                            file.name,

                            file.bytes!,
                          );
                        });
                      }
                    }
                  },

                  child: Container(

                    width:
                        double.infinity,

                    height: 120,

                    decoration: BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),

                      border: Border.all(

                        color:
                            Colors.green
                                .shade200,

                        width: 1.5,
                      ),

                      color:
                          const Color(
                        0xFFF8FCF9,
                      ),
                    ),

                    child: Column(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        Icon(

                          Icons.upload_file,

                          size: 42,

                          color:
                              Colors.green
                                  .shade700,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(

                          "Cliquer pour importer un fichier Excel",

                          textAlign:
                              TextAlign.center,

                          style: TextStyle(

                            fontSize: 15,

                            fontWeight:
                                FontWeight
                                    .w500,

                            color:
                                Colors.grey
                                    .shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // 🔥 BUTTON
                SizedBox(

                  width:
                      double.infinity,

                  height: 54,

                  child: ElevatedButton(

                    onPressed: () async {
                             

                        // 🔥 CHECK CYCLE
if (cycleSelectionne == null) {

  setState(() {

    controller.importError(

      "Veuillez sélectionner un cycle",
    );
  });

  return;
}

                      // 🔥 CHECK FILIERE
                      if (filiereController
                          .text
                          .trim()
                          .isEmpty) {

                        setState(() {

                          controller.importError(

                            "Veuillez entrer la filière",
                          );
                        });

                        return;
                      }

                      // 🔥 CHECK NIVEAU
                      if (niveauController
                          .text
                          .trim()
                          .isEmpty) {

                        setState(() {

                          controller.importError(

                            "Veuillez entrer le niveau",
                          );
                        });

                        return;
                      }

                      // 🔥 CHECK FILE
                      if (controller
                                  .state
                                  .fileBytes ==
                              null ||

                          controller
                              .state
                              .fileBytes!
                              .isEmpty) {

                        setState(() {

                          controller.importError(

                            "Veuillez sélectionner un fichier Excel",
                          );
                        });

                        return;
                      }

                      // 🔥 LOADING
                      showDialog(

                        context: context,

                        barrierDismissible:
                            false,

                        builder: (_) {

                          return const Center(

                            child:
                                CircularProgressIndicator(),
                          );
                        },
                      );

                    final resultat =
    await importService.importExcel(
      controller.state.fileBytes!,
      controller.state.fileName!,
      cycleSelectionne!,
      filiereController.text.trim(),
      niveauController.text.trim(),
    );
    print("SUCCESS = ${resultat.success}");
print("MESSAGE = ${resultat.message}");

                      Navigator.pop(context);

                      // 🔥 SUCCESS
     setState(() {
  if (resultat.success) {
    controller.importSuccess(resultat.message);
  } else {
    controller.importError(resultat.message);
  }
});
print("CONTROLLER = ${controller.state.message}");
}, 

                    style:
                        ElevatedButton.styleFrom(

                      elevation: 0,

                      backgroundColor:
                          const Color(
                        0xFF2D6A4F,
                      ),

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius
                                .circular(
                          16,
                        ),
                      ),
                    ),

                    child: const Text(

                      "Importer",

                      style: TextStyle(

                        fontSize: 16,

                        fontWeight:
                            FontWeight.bold,

                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // 🔥 MESSAGE
                if (controller
                        .state
                        .message !=
                    null)

                  Container(

                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets.all(
                      14,
                    ),

                    decoration: BoxDecoration(

                      color:

                          controller
                                  .state
                                  .isError

                              ? const Color(
                                  0xFFFFF1F1,
                                )

                              : const Color(
                                  0xFFE8F5EE,
                                ),

                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),

                    child: Text(

                      controller
                          .state
                          .message!,

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        color:

                            controller
                                    .state
                                    .isError

                                ? Colors.red
                                    .shade700

                                : Colors.green
                                    .shade700,

                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}