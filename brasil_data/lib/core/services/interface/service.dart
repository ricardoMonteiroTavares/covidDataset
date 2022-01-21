import 'package:brasil_data/core/models/model.dart';
import 'package:brasil_data/core/util/or.dart';

/// Interface para a realiação de um serviço.
/// A classe [T] é o model que representa a entrada de dados
/// A classe [K] é o model que representa a saída de dados
abstract class Service<T, K extends OutputModel> {
  Future<Or<K, String>> action(T data);
}
