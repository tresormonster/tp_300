import '../state/import_state.dart';

class ImportController {

  ImportState state =
      ImportState(

    fileName: null,

    fileBytes: null,

    message: null,

    isError: false,

    isImported: false,
  );

  void setFile(

    String fileName,

    List<int> fileBytes,
  ) {

    state = ImportState(

      fileName: fileName,

      fileBytes: fileBytes,

      message: null,

      isError: false,

      isImported: false,
    );
  }

  void importSuccess(String message) {

  state = ImportState(

    fileName: state.fileName,

    fileBytes: state.fileBytes,

    message: message,

    isError: false,

    isImported: true,
  );
}

  void importError(
    String message,
  ) {

    state = ImportState(

      fileName:
          state.fileName,

      fileBytes:
          state.fileBytes,

      message: message,

      isError: true,

      isImported: false,
    );
  }
}