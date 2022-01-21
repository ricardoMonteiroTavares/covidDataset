/// Interface genérica para a implementação de um Repositório,
/// cuja a entrada de dados deverá ser do tipo [T]
abstract class Repository<T> {
  /// A função [get] faz a busca em um banco de dados remoto.
  /// Esta busca poderá ter ou não parâmetros requisitados em [data].
  Future<dynamic> get([T? data]);

  /// A função [remove] faz a remoção de um determinado valor em um banco de dados remoto.
  /// Para realizar esta operação, não é obrigatório possuir os valores presentes em [data],
  /// pois isso ficará a critério de cada repositório implmentado.
  Future<dynamic> remove([T? data]);
}
