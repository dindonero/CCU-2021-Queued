class DataInException implements Exception {
  final _message;

  DataInException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
