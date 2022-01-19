class InvalidEmailException implements Exception {
  @override
  String toString() => "E-mail inválido";
}

class IncorrectPasswordException implements Exception {
  @override
  String toString() => "Senha incorreta";
}
