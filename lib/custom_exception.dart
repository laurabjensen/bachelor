class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  String get errorMessage => 'Noget gik galt: $message';
}
