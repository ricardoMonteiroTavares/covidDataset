class FailedException implements Exception {
  @override
  String toString() =>
      "Não foi possível realizar esta operação! Tente novamente mais tarde!";
}
