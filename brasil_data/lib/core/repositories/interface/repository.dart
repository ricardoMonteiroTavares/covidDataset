/// Interface genérica para a implementação de um Repositório,
/// cuja a entrada de dados deverá ser do tipo [T]
abstract class Repository<T> {
  /// A função [get] faz a busca em um banco de dados remoto.
  /// Esta busca poderá ter ou não parâmetros requisitados em [data].
  Future<dynamic> get([T? data]);
}

mixin RemoveAllOp {
  /// A função [removeAll] faz a remoção de todos os valores em um banco de dados remoto.
  Future<dynamic> removeAll();
}

mixin SetOP<T> {
  /// A função [set] faz a modificação de um valor em um banco de dados remoto.
  /// Esta modificação só poderá ser realizada com parâmetros requisitados em [data].
  Future<dynamic> set(T data);
}
