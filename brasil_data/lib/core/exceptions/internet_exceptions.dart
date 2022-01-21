class NotFoundException implements Exception {
  @override
  String toString() => "Error: Não localizado";
}

class BadRequestException implements Exception {
  final Iterable<String> fields;
  BadRequestException(this.fields);
  @override
  String toString() => "Os campos ${fields.join(', ')} estão incorretos";
}

class NoInternetException implements Exception {
  @override
  String toString() => "Sem conexão!";
}
