class HttpException implements Exception {
  final String _message;

  HttpException({required message}) : _message = message;

  @override
  String toString() {
    return _message;
  }
}
