class ImportState {

  final String? fileName;

  final List<int>? fileBytes;

  final String? message;

  final bool isError;

  final bool isImported;

  ImportState({

    required this.fileName,

    required this.fileBytes,

    required this.message,

    required this.isError,

    required this.isImported,
  });
}