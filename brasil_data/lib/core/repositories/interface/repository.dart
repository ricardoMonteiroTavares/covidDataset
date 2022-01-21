/// Interface genérica para a implementação de um Repositório,
/// cuja a entrada de dados deverá ser do tipo [T]
abstract class Repository<T> {
  /// A função [get] faz a busca em um banco de dados remoto.
  /// Esta busca poderá ter ou não parâmetros requisitados em [data].
  Future<dynamic> get([T? data]);
}
