class MyAuthException implements Exception {
  String reason;
  String description;
  MyAuthException(this.reason, this.description);

  @override
  String toString() {
    return 'AuthLoginException: $reason, $description';
  }
}
