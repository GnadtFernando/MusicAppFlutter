class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });
}

class GeneralException implements Exception {
  final String message;
  GeneralException({
    this.message = "Ocorreu um erro. Tente novamente",
  });
}
